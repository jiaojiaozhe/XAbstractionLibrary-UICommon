//
//  TabBarViewController.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "TabBar.h"
#import "TabBarItem.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "DemoViewController1.h"
#import "DemoViewController2.h"
#import "DemoViewController3.h"
#import "AIDiscoverViewController.h"
#import "NavigationController.h"
#import "TabBarViewController.h"
#import "NavigationControllerManager.h"

@interface TabBarViewController()
@property (nonatomic,strong) TabBarItem *currentTabBarItem;
@end

@implementation TabBarViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.tabBarDelegate = [NavigationControllerManager sharePageManager];
    }
    return self;
}

- (NSArray *)tabBarViewControllers{
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:[super tabBarViewControllers]];
    
    ViewController1 *controller1 = [[ViewController1 alloc] init];
    NavigationController *nav1 = [[NavigationController alloc] initWithRootViewController:controller1];
    nav1.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
    [controllers addObject:nav1];
    
    ViewController2 *controller2 = [[ViewController2 alloc] init];
    NavigationController *nav2 = [[NavigationController alloc] initWithRootViewController:controller2];
    nav2.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
    [controllers addObject:nav2];
    
    ViewController3 *controller3 = [[ViewController3 alloc] init];
    NavigationController *nav3 = [[NavigationController alloc] initWithRootViewController:controller3];
    nav3.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
    [controllers addObject:nav3];
    
//    DemoViewController2 *demoController4 = [[DemoViewController2 alloc] init];
//    NavigationController *nav4 = [[NavigationController alloc] initWithRootViewController:demoController4];
//    nav4.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
//    [controllers addObject:nav4];
    
    AIDiscoverViewController *demoController4 = [[AIDiscoverViewController alloc] init];
    NavigationController *nav4 = [[NavigationController alloc] initWithRootViewController:demoController4];
    nav4.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
    [controllers addObject:nav4];
    
    DemoViewController3 *demoController5 = [[DemoViewController3 alloc] init];
    NavigationController *nav5 = [[NavigationController alloc] initWithRootViewController:demoController5];
    nav5.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
    [controllers addObject:nav5];
    
    
//    ViewController4 *controller4 = [[ViewController4 alloc] init];
//    NavigationController *nav4 = [[NavigationController alloc] initWithRootViewController:controller4];
//    nav4.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
//    [controllers addObject:nav4];
//
//    ViewController5 *controller5 = [[ViewController5 alloc] init];
//    NavigationController *nav5 = [[NavigationController alloc] initWithRootViewController:controller5];
//    nav5.currentNavigationDelegate = [NavigationControllerManager sharePageManager];
//    [controllers addObject:nav5];
    
    return controllers;
}

- (CGFloat) tabBarHeight{
    XTabBar *tabBar = [TabBar createTabBar];
    return VIEW_HEIGHT(tabBar);
}

- (XTabBar *)tabBarView{
    TabBar *tabBar = [TabBar createTabBar];
    [tabBar addTarget:self action:@selector(clickTabBarItem:)];
    return tabBar;
}

- (void) clickTabBarItem:(TabBarItem *) tabBarItem{
    if(self.currentTabBarItem.itemTag != tabBarItem.itemTag)
        _currentTabBarItem = tabBarItem;
    [self selectedTabBarItemWithTag:_currentTabBarItem.itemTag];
}

- (void) selectedTabBarItemWithTag:(TabBarItemTag) itemTag{
    if(self.selectedIndex == itemTag){
        if([self.tabBarDelegate respondsToSelector:@selector(tabBarControllerReChooie:)]){
            [self.tabBarDelegate tabBarControllerReChooie:self];
        }
    }
    else{
        self.selectedIndex = itemTag;
        if([self.tabBarDelegate respondsToSelector:@selector(tabBarControllerChange:)])
            [self.tabBarDelegate tabBarControllerChange:self];
    }
}

@end
