//
//  XTabBarController.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/30.
//

#import "XTabBar.h"
#import "XTabBarController.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface XTabBarController ()
@property (nonatomic,strong) UIView *systemTabBar;
@property (nonatomic,strong) UIView *systemTransitionView;
@property (nonatomic,strong) XTabBar *systemTabBarItemsView;
@end

@implementation XTabBarController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if(version >= 7.0){
            self.edgesForExtendedLayout = UIRectEdgeNone;
            if(@available(iOS 11.0, *)){
                //self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }else{
                //11.0以后的OS需要设置ScrollView的contentInsetAdjustmentBehavior
                self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewControllers = [self tabBarViewControllers];
    [self initTabBar];
}

- (XTabBar *)systemTabBarItemsView{
    if(!_systemTabBarItemsView){
        _systemTabBarItemsView = [self tabBarView];
    }
    return _systemTabBarItemsView;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if(!([[self.systemTabBar subviews] count] <= 0)){
        CGFloat bottom = self.bottomLayoutGuide.length;
        XTabBar *tabBar = [self systemTabBarItemsView];
        CGFloat tabBarHeight = VIEW_HEIGHT(tabBar) + bottom;
        SET_VIEW_HEIGHT(tabBar, tabBarHeight);
        
        //CGFloat tabBarHeight = [self tabBarHeight];
        CGFloat space = VIEW_HEIGHT(self.systemTabBar) - tabBarHeight;
        
        SET_VIEW_TOP(self.systemTabBar, VIEW_TOP(self.systemTabBar) + space);
        SET_VIEW_HEIGHT(self.systemTabBar, tabBarHeight);
        
        SET_VIEW_HEIGHT(self.systemTransitionView,VIEW_HEIGHT(self.systemTransitionView) + space);
        
        UIView *systemTabBarSuper = [[UIView alloc] init];
        systemTabBarSuper.backgroundColor = [UIColor redColor];
        SET_VIEW_WIDTH(systemTabBarSuper, VIEW_WIDTH(self.systemTabBar));
        SET_VIEW_HEIGHT(systemTabBarSuper, VIEW_HEIGHT(self.systemTabBar))
        [self.systemTabBar addSubview:systemTabBarSuper];
        
        self.systemTabBarItemsView = [self systemTabBarItemsView];
        if(self.systemTabBarItemsView){
            SET_VIEW_WIDTH(self.systemTabBarItemsView, VIEW_WIDTH(systemTabBarSuper));
            SET_VIEW_HEIGHT(self.systemTabBarItemsView, VIEW_HEIGHT(systemTabBarSuper));
            [systemTabBarSuper addSubview:self.systemTabBarItemsView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *) tabBarViewControllers{
    NSMutableArray *controllers = [NSMutableArray array];
    return controllers;
}

- (XTabBar *) tabBarView{
    return nil;
}

- (CGFloat) tabBarHeight{
    return VIEW_HEIGHT(self.tabBar);
}

- (void) initTabBar{
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UITabBar class]]){
            self.systemTabBar = view;
            self.systemTabBar.backgroundColor = [UIColor clearColor];
        }
        else{
            self.systemTransitionView = view;
            self.systemTransitionView.backgroundColor = [UIColor clearColor];
        }
    }
}

- (UIViewController *) tabBarControllerWithIndex:(NSInteger) index{
    if(index <0 || index >= self.viewControllers.count)
        return nil;
    return [self.viewControllers objectAtIndex:index];
}

@end
