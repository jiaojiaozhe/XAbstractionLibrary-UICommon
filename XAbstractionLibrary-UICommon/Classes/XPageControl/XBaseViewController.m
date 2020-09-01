//
//  XBaseViewController.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/20.
//

#import "XBaseView.h"
#import "XHeadView.h"
#import "XBaseViewController.h"

@interface XBaseViewController ()

/**
 页面头部区
 */
@property (nonatomic,strong) XHeadView *headView;

/**
 内容区
 */
@property (nonatomic,strong) XBaseView *mContentView;

/**
 当前页面是否是作为其他视图控制器的子控制器存在
 */
@property (nonatomic,assign) BOOL bContainer;

/**
 顶部headView的高度约束
 */


@property (nonatomic,strong) NSLayoutConstraint *leftConstraint;
@property (nonatomic,strong) NSLayoutConstraint *topConstraint;
@property (nonatomic,strong) NSLayoutConstraint *rightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *heightConstraint;

/**
 请求对象的集合
 */
@property (nonatomic,strong) NSMutableDictionary *requests;
@end

@implementation XBaseViewController

+ (instancetype) createViewController{
    XBaseViewController *viewController = [[[self class] alloc] init];
    return viewController;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    NSBundle *bundle = nil;
    if(nibBundleOrNil){
        bundle = nibBundleOrNil;
    }else{
        Class class = [XBaseViewController class];
//        NSString *className = NSStringFromClass(class);
        NSBundle *frameWorkBundle = [NSBundle bundleForClass: class];
        NSString *projectName = [[[[frameWorkBundle bundlePath] lastPathComponent] stringByDeletingPathExtension] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
        NSString *frameWorkBundlePath = [frameWorkBundle pathForResource:projectName
                                                                  ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:frameWorkBundlePath];
    }
    
    if(self = [super initWithNibName:nibNameOrNil bundle:bundle]){
        
    }
    return self;
}

- (instancetype) init{
    if(self = [super init]){
        self.requests = [NSMutableDictionary dictionary];
        [self registerBroadcastReceiver];
    }
    return self;
}

- (void) setHeadView{
    if(!self.headView){
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat headerTop = -statusRect.size.height;
        if(self.bContainer){
            headerTop = 0;
        }
        
        self.headView = [XHeadView createHeadViewWithDelegate:self];
        if(![self getHeadLeftView] &&
           ![self getHeadCenterView] &&
           ![self getHeadRightView]){
            headerTop -=  VIEW_HEIGHT(self.headView);
        }
        
        [self.view addSubview:self.headView];
        CGFloat height = VIEW_HEIGHT(self.headView);
        self.headView.translatesAutoresizingMaskIntoConstraints = NO;
        _leftConstraint = [NSLayoutConstraint constraintWithItem:self.headView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0];
        [self.view addConstraint:_leftConstraint];
        
        if (@available(iOS 11.0, *)) {
            _topConstraint = [NSLayoutConstraint constraintWithItem:self.headView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view.safeAreaLayoutGuide
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:headerTop];
        } else {
            // Fallback on earlier versions
            _topConstraint = [NSLayoutConstraint constraintWithItem:self.headView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:headerTop];
        }
        
        [self.view addConstraint:_topConstraint];
        _rightConstraint = [NSLayoutConstraint constraintWithItem:self.headView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0.0];
        [self.view addConstraint:_rightConstraint];
        
        _heightConstraint = [NSLayoutConstraint constraintWithItem:self.headView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:height];
        [self.view addConstraint:_heightConstraint];
        
        [self.headView setNeedsLayout];
        [self.headView layoutIfNeeded];
    }
}

- (void) setShowLine:(BOOL) bShow{
    [self.headView setShowLine:bShow];
}

- (void) setLineColor:(UIColor *) color{
    [self.headView setLineColor:color];
}

- (XBaseView *) loadViewPresenter{
    return NULL;
}

- (void) setContentView{
    if(!self.mContentView){
        XBaseView *contentView = [self loadViewPresenter];
        if(!contentView){
            contentView = [[XBaseView alloc] init];
            [contentView setBackgroundColor:[UIColor whiteColor]];
        }
        self.mContentView = contentView;
        [self.view addSubview:self.mContentView];
    }else{
        //通过xib或其他途径创建了对应的内容页
    }
    
    self.mContentView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.headView
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0f
                                                                            constant:0.0f];
    [self.view addConstraint:topLayoutConstraint];
    
    NSLayoutConstraint *leftLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0f
                                                                             constant:0.0f];
    [self.view addConstraint:leftLayoutConstraint];
    
    
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *bottomLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.view.safeAreaLayoutGuide
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1.0f
                                                                                   constant:0.f];
        [self.view addConstraint:bottomLayoutConstraint];
    } else {
        // Fallback on earlier versions
        NSLayoutConstraint *bottomLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self.bottomLayoutGuide
                                                                                  attribute:NSLayoutAttributeTop
                                                                                 multiplier:1.0f
                                                                                   constant:0.f];
        [self.view addConstraint:bottomLayoutConstraint];
    }
    
    NSLayoutConstraint *rightLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0f
                                                                              constant:0.0f];
    [self.view addConstraint:rightLayoutConstraint];
    [self.mContentView setNeedsLayout];
    [self.mContentView layoutIfNeeded];
}

- (void) willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    
    if([parent isKindOfClass:[UIPageViewController class]]){
        self.bContainer = YES;
    }
}

- (void) addChildViewController:(UIViewController *)childController{
    if(!childController){
        return;
    }
    
    [super addChildViewController:childController];
    if([childController isKindOfClass:[UIPageViewController class]]){
        UIPageViewController *pageViewController = (UIPageViewController*)childController;
        NSArray *viewControllers = [pageViewController childViewControllers];
        for(UIViewController *controller in viewControllers){
            XBaseViewController *baseViewController = (XBaseViewController *) controller;
            baseViewController.bContainer = YES;
        }
    }else if([childController isKindOfClass:[XBaseViewController class]]){
        XBaseViewController *baseViewController = (XBaseViewController *) childController;
        baseViewController.bContainer = YES;
    }
}

- (void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat headerTop = -statusRect.size.height;
    if(self.bContainer){
        headerTop = 0;
    }
    
    if(![self getHeadLeftView] &&
       ![self getHeadCenterView] &&
       ![self getHeadRightView]){
        headerTop -=  VIEW_HEIGHT(self.headView);
    }
    CGFloat height = VIEW_HEIGHT(self.headView);
    
    _topConstraint.constant = headerTop;
    _heightConstraint.constant = height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setHeadView];
    [self setContentView];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)dealloc{
    [self unregisterBroadcastReceiver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) broadcastReceiver:(NSNotification *)notification view:(UIView *) view{
    if(view){
        if([view isKindOfClass:[XBaseView class]]){
            XBaseView *xview = (XBaseView *)view;
            [xview onMyBroadcastReceiver:notification];
        }
        
        NSArray *subViews = [view subviews];
        for(NSInteger index = 0; index < [subViews count]; index++){
            UIView *subView = [subViews objectAtIndex:index];
            if([subView isKindOfClass:[XBaseView class]]){
                XBaseView *xSubVuew = (XBaseView*)subView;
                [xSubVuew onMyBroadcastReceiver:notification];
            }
        }
    }
}

- (void) onMyBroadcastReceiver:(NSNotification *) notification{
    [self broadcastReceiver:notification view:self.mContentView];
}

- (void) onSendMyBroadcast:(XNotification_Action) action dataInfo:(NSDictionary *) dataInfo{
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dataInfo];
    [data setObject:@(action) forKey:NOTIFICATION_ACTION];
    [[NSNotificationCenter defaultCenter] postNotificationName:GLOBAL_UI_ACTION_NOTIFICATION
                                                        object:data];
}

- (void) registerBroadcastReceiver{
    [self unregisterBroadcastReceiver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMyBroadcastReceiver:)
                                                 name:GLOBAL_UI_ACTION_NOTIFICATION
                                               object:nil];
}

- (void) unregisterBroadcastReceiver{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:GLOBAL_UI_ACTION_NOTIFICATION
                                                  object:nil];
}

#pragma mark --
#pragma mark --XHttpResponseDelegate
- (void) cancelRequest:(id<XHttpRequestDelegate>) request{
    if(self.mContentView &&
       [self.mContentView respondsToSelector:@selector(cancelRequest:)]){
        [self.mContentView cancelRequest:request];
    }
    
    if(request && [request isKindOfClass:[XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
        if([httpRequest.ID length] > 0){
            [self.requests removeObjectForKey:httpRequest.ID];
        }
    }
}

- (void) willStartRequest:(id<XHttpRequestDelegate>) request{
    if(self.mContentView &&
       [self.mContentView respondsToSelector:@selector(willStartRequest:)]){
        [self.mContentView willStartRequest:request];
    }
    
    if(request && [request isKindOfClass:[XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
        if([httpRequest.ID length] > 0){
            [self.requests setObject:httpRequest forKey:httpRequest.ID];
        }
    }
}

- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest{
    if(self.mContentView &&
       [self.mContentView respondsToSelector:@selector(willRetryRequest:newRequest:)]){
        [self.mContentView willRetryRequest:oldRequest newRequest:newRequest];
    }
    
    if(oldRequest &&
       [oldRequest isKindOfClass:[XBaseHttpRequest class]] &&
       newRequest &&
       [newRequest isKindOfClass:[XBaseHttpRequest class]]){
        XBaseHttpRequest *oldHttpRequest = (XBaseHttpRequest*)oldRequest;
        XBaseHttpRequest *newHttpRequest = (XBaseHttpRequest*)newRequest;
        if([oldHttpRequest.ID length] > 0)
            [self.requests removeObjectForKey:oldHttpRequest.ID];
        if([newHttpRequest.ID length] > 0)
            [self.requests setObject:newHttpRequest forKey:newHttpRequest.ID];
    }
}

- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress{
    if(self.mContentView &&
       [self.mContentView respondsToSelector:@selector(execWithRequest:progress:totalProgress:)]){
        [self.mContentView execWithRequest:request
                                 progress:progress
                            totalProgress:totalProgress];
    }
}


- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error{
    if(self.mContentView &&
       [self.mContentView respondsToSelector:@selector(completeDidRequest:responseDic:error:)]){
        [self.mContentView completeDidRequest:request
                                 responseDic:responseDic
                                       error:error];
    }
    
    if(request &&
       [request isKindOfClass:[XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
        if([httpRequest.ID length] > 0)
            [self.requests removeObjectForKey:httpRequest.ID];
    }
}

#pragma mark --
#pragma mark --XHeadViewDelegate
- (UIView *) getHeadLeftView{
    return nil;
}

- (UIView *) getHeadRightView{
    return nil;
}

- (UIView *) getHeadCenterView{
    return nil;
}
@end
