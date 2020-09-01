//
//  UIViewController+PushTransistion.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/31.
//

#import "XPushTransitionAnimation.h"
#import "UIViewController+PushTransistion.h"

//有效的向右拖动的最小速率，即为大于这个速率就认为想返回上一页
#define kPushTransitionConstantMinVelocity 300.0f

NSString * const kStopDrag = @"__StopDrag";
NSString * const kPushTransitionInteractivePopTransition = @"pushTransitionInteractivePopTransition";
NSString * const kPushTransitionGestureRecognizer = @"pushTransitionGestureRecognizer";
NSString * const kPushTransitionViewControllerOfPan = @"pushTransitionViewControllerOfPan";

//设置一个默认的全局使用的type
static PushTransitionGestureRecognizerType pushTransitionGestureRecognizerType = PushTransitionGestureRecognizerTypePan;

//静态就交换静态，实例方法就交换实例方法
void PushTransitionSwizzle(Class c, SEL origSEL, SEL newSEL){
    //获取实例方法
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
    if (!origMethod) {
        //获取静态方法
        origMethod = class_getClassMethod(c, origSEL);
        newMethod = class_getClassMethod(c, newSEL);
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
    }
    
    if (!origMethod||!newMethod) {
        return;
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        //添加成功一般情况是因为，origSEL本身是在c的父类里。这里添加成功了一个继承方法。
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@interface UIGestureRecognizer(PushTransistion)
@property (nonatomic, assign) UIViewController *pushTransitionViewController;
@end

@implementation UIGestureRecognizer(PushTransistion)
- (void)setPushTransitionViewController:(UIViewController *) pushTransitionViewController{
    [self willChangeValueForKey:kPushTransitionViewControllerOfPan];
    objc_setAssociatedObject(self, &kPushTransitionViewControllerOfPan, pushTransitionViewController, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kPushTransitionViewControllerOfPan];
}

- (UIViewController *) pushTransitionViewController{
    return objc_getAssociatedObject(self, &kPushTransitionViewControllerOfPan);
}
@end


//作为手势的delegate，原因是如果delegate是当前vc则可能产生子类覆盖的情况
@interface PushTransistionGestureDelegateObject : NSObject<UIGestureRecognizerDelegate>
@end

@implementation PushTransistionGestureDelegateObject

+ (instancetype)shareInstance {
    static PushTransistionGestureDelegateObject *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc]init];
    });
    return shareInstance;
}


//直接在这处理的话对性能有好处。
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    UIViewController *vc = gestureRecognizer.pushTransitionViewController;
    if (!vc) {
        return NO;
    }
    
    UIViewController *controller = [vc.navigationController topViewController];
    if([controller isKindOfClass:[UITabBarController class]])
        return NO;
    
    if (!vc.navigationController||
        [vc.navigationController.transitionCoordinator isAnimated]||
        vc.navigationController.viewControllers.count < 2) {
        return NO;
    }
    
    //普通拖曳模式，如果开始方向不对即不启用
    if (pushTransitionGestureRecognizerType == PushTransitionGestureRecognizerTypePan
        &&[gestureRecognizer velocityInView:vc.view].x<=0) {
        return NO;
    }
    
    return YES;
}
@end


@interface UIViewController()<UINavigationControllerDelegate>
@property (nonatomic,assign) BOOL bStopDrag;
@property (nonatomic, strong) UIGestureRecognizer *pushTransitionGestureRecognizer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractivePopTransition;
@end

@implementation UIViewController (PushTransistion)

+ (void)validatePanWithPushTransitionGestureRecognizerType:(PushTransitionGestureRecognizerType)type{
    //整个程序的生命周期只允许执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //设置记录type,并且执行hook
        pushTransitionGestureRecognizerType = type;
        
        PushTransitionSwizzle([self class],@selector(viewDidLoad),@selector(pushTransitionHookViewDidLoad));
        PushTransitionSwizzle([self class],@selector(viewDidAppear:),@selector(pushTransitionHookViewDidAppear:));
        PushTransitionSwizzle([self class],@selector(viewWillDisappear:),@selector(pushTransitionHookViewWillDisappear:));
        PushTransitionSwizzle([self class], NSSelectorFromString(@"dealloc"),@selector(pushTransitionHookDealloc));
    });
}

#pragma mark - add property
- (void)setPercentDrivenInteractivePopTransition:(UIPercentDrivenInteractiveTransition *)percentDrivenInteractivePopTransition{
    [self willChangeValueForKey:kPushTransitionInteractivePopTransition];
    objc_setAssociatedObject(self, &kPushTransitionInteractivePopTransition, percentDrivenInteractivePopTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kPushTransitionInteractivePopTransition];
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenInteractivePopTransition{
    return objc_getAssociatedObject(self, &kPushTransitionInteractivePopTransition);
}

- (void)setPushTransition_gestureRecognizer:(UIGestureRecognizer *)pushTransitionGestureRecognizer{
    [self willChangeValueForKey:kPushTransitionGestureRecognizer];
    objc_setAssociatedObject(self, &kPushTransitionGestureRecognizer, pushTransitionGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kPushTransitionGestureRecognizer];
}

- (UIGestureRecognizer *)pushTransitionGestureRecognizer{
    return objc_getAssociatedObject(self, &kPushTransitionGestureRecognizer);
}

- (void) setBStopDrag:(BOOL) bStop{
    [self willChangeValueForKey:kStopDrag];
    objc_setAssociatedObject(self, &kStopDrag, @(bStop), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kStopDrag];
}

- (BOOL) bStopDrag{
    NSNumber  *number = objc_getAssociatedObject(self, &kStopDrag);
    if(number)
        return [number boolValue];
    return NO;
}

#pragma mark - hook
- (void) pushTransitionHookViewDidLoad
{
    [self pushTransitionHookViewDidLoad];
    
    if ([self bStopDrag]) {
        return;
    }
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    if (!self.pushTransitionGestureRecognizer) {
        UIGestureRecognizer *gestureRecognizer = nil;
        if (pushTransitionGestureRecognizerType == PushTransitionGestureRecognizerTypeScreenEdgePan) {
            gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pushTransitionHandlePopRecognizer:)];
            ((UIScreenEdgePanGestureRecognizer*)gestureRecognizer).edges = UIRectEdgeLeft;
        }else{
            gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pushTransitionHandlePopRecognizer:)];
        }
        
        gestureRecognizer.pushTransitionViewController = self;
        gestureRecognizer.delegate = [PushTransistionGestureDelegateObject shareInstance];
        
        self.pushTransition_gestureRecognizer = gestureRecognizer;
        [self.view addGestureRecognizer:gestureRecognizer];
    }
}

- (void) pushTransitionHookViewDidAppear:(BOOL)animated {
    [self pushTransitionHookViewDidAppear:animated];
    
    if (![self isKindOfClass:[UINavigationController class]]) {
        //经过测试，只有delegate是vc的时候vc的title或者navigationItem.titleView才会跟着移动。
        //所以在下并没有使用一个单例一直作为delegate存在，单例的话效果和新版QQ一样，title不会移动，但是也会有fade效果啦。
        self.navigationController.delegate = self;
    }
}

- (void) pushTransitionHookViewWillDisappear:(BOOL)animated {
    [self pushTransitionHookViewWillDisappear:animated];
    
    if (![self isKindOfClass:[UINavigationController class]]) {
        if (self.navigationController.delegate == self) {
            self.navigationController.delegate = nil;
        }
    }
}

- (void) pushTransitionHookDealloc{
    self.pushTransitionGestureRecognizer.delegate = nil;
    self.pushTransitionGestureRecognizer.pushTransitionViewController = nil;
    [self pushTransitionHookDealloc];
}

#pragma mark - UINavigationControllerDelegate
- (void) navigationController:(UINavigationController *)navigationController
        didShowViewController:(UIViewController *)viewController
                     animated:(BOOL)animated{
    if([navigationController isMemberOfClass:[UIImagePickerController class]])
        return;
    if([navigationController respondsToSelector:@selector(navigationController:didShowViewController:animated:)])
        [navigationController navigationController:navigationController
                             didShowViewController:viewController
                                          animated:animated];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (fromVC == self) {
        if (operation == UINavigationControllerOperationPop) {
            XPushTransitionAnimation *animationController = [XPushTransitionAnimation new];
            animationController.type = PushTransitionAnimationTypePop;
            return animationController;
        }
        else{
            XPushTransitionAnimation *animationController = [XPushTransitionAnimation new];
            animationController.type = PushTransitionAnimationTypePush;
            return animationController;
        }
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[XPushTransitionAnimation class]]) {
        return self.percentDrivenInteractivePopTransition;
    }
    
    return nil;
}

#pragma mark - UIGestureRecognizer handlers
- (void)pushTransitionHandlePopRecognizer:(UIPanGestureRecognizer*)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //建立一个transition的百分比控制对象
        self.percentDrivenInteractivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        self.percentDrivenInteractivePopTransition.completionCurve = UIViewAnimationCurveEaseInOut;
        
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (!self.percentDrivenInteractivePopTransition) {
        return;
    }
    
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0f);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        //根据拖动调整transition状态
        [self.percentDrivenInteractivePopTransition updateInteractiveTransition:progress];
    }else if ((recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)) {
        //结束或者取消了手势，根据方向和速率来判断应该完成transition还是取消transition
        CGFloat velocity = [recognizer velocityInView:self.view].x; //我们只关心x的速率
        
        if (velocity > kPushTransitionConstantMinVelocity) { //向右速率太快就完成
            self.percentDrivenInteractivePopTransition.completionSpeed /= 1.0f;
            [self.percentDrivenInteractivePopTransition finishInteractiveTransition];
        }else if (velocity < -kPushTransitionConstantMinVelocity){ //向左速率太快就取消
            self.percentDrivenInteractivePopTransition.completionSpeed /= 1.0f;
            [self.percentDrivenInteractivePopTransition cancelInteractiveTransition];
        }else{
            BOOL isFinished = NO;
            if (progress > 0.8f || (progress>=0.2f&&velocity>0.0f)) {
                isFinished = YES;
            }
            if (isFinished) {
                self.percentDrivenInteractivePopTransition.completionSpeed /= 1.5f;
                [self.percentDrivenInteractivePopTransition finishInteractiveTransition];
            }else{
                self.percentDrivenInteractivePopTransition.completionSpeed /= 2.0f;
                [self.percentDrivenInteractivePopTransition cancelInteractiveTransition];
            }
        }
        self.percentDrivenInteractivePopTransition = nil;
    }
}

@end
