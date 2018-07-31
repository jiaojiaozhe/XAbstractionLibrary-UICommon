//
//  NavigationControllerManager.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationControllerManager.h"

@interface NavigationControllerManager()
@property (nonatomic,strong) NavigationController *rootNavigationController;
@property (nonatomic,weak) UIViewController *tabCurrentController;
@end

@implementation NavigationControllerManager

+ (instancetype) sharePageManager{
    static NavigationControllerManager *pageManager = nil;
#if !__has_feature(objc_arc)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pageManager = [NSAllocateObject([self class], 0, nil) init];
    });
#else
    pageManager = [[self class] alloc];
#endif
    return pageManager;
}

+ (id) allocWithZone:(struct _NSZone *)zone{
#if !__has_feature(objc_arc)
    return [[self sharePageManager] retain];
#else
    static NavigationControllerManager *pageManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pageManager = [[super allocWithZone:zone] init];
    });
    return pageManager;
#endif
}

#if !__has_feature(objc_arc)
- (id) retain{
    return self;
}

- (NSUInteger) retainCount{
    return NSUIntegerMax;
}

- (id) autorelease{
    return self;
}

- (oneway void) release{
    
}
#endif

- (id) copyWithZone:(NSZone *)zone{
    return self;
}

- (NavigationController *) rootNavigationController{
    if(!_rootNavigationController){
        MainViewController *mainViewController = [[MainViewController alloc] init];
        _rootNavigationController = [[NavigationController alloc] initWithRootViewController:mainViewController];
        _rootNavigationController.bMainController = YES;
        _rootNavigationController.currentNavigationDelegate = self;
    }
    return _rootNavigationController;
}

- (void) pushViewControllerOnMain:(UIViewController *)controller
                         animated:(BOOL)animated{
    __weak typeof(self) weakSelf = self;
    if(self.rootNavigationController.presentedViewController)
        [self.rootNavigationController dismissViewControllerAnimated:NO completion:^{
            [weakSelf.rootNavigationController pushViewController:controller animated:animated];
        }];
    else
        [self.rootNavigationController pushViewController:controller animated:animated];
}

- (UIViewController *) popViewControllerOnMain:(BOOL) animated{
    return [self.rootNavigationController popViewControllerAnimated:animated];
}

- (NSArray *) popToRootViewControllerOnMain:(BOOL) animated{
    return [self.rootNavigationController popToRootViewControllerAnimated:animated];
}

- (NSArray *) popToViewControllerOnMain:(UIViewController *) controller animated:(BOOL) animated{
    return [self.rootNavigationController popToViewController:controller animated:animated];
}


- (void) pushViewControllerOnTab:(UIViewController *) controller
                        animated:(BOOL) animated
{
    UINavigationController *navigationController = [self.tabCurrentController navigationController];
    if(navigationController.presentedViewController){
        [navigationController dismissViewControllerAnimated:NO completion:^{
            [navigationController pushViewController:controller animated:animated];
        }];
    }
    else{
        [navigationController pushViewController:controller animated:animated];
    }
}

- (UIViewController *) popViewControllerOnTab:(BOOL) animated
{
    UINavigationController *navigationController = [self.tabCurrentController navigationController];
    return [navigationController popViewControllerAnimated:animated];
}

- (NSArray *) popToRootViewControllerOnTab:(BOOL) animated
{
    UINavigationController *navigationController = [self.tabCurrentController navigationController];
    return [navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray *) popToViewControllerOnTab:(UIViewController *) controller
                              animated:(BOOL) animated
{
    UINavigationController *navigationController = [self.tabCurrentController navigationController];
    return [navigationController popToViewController:controller animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent
                     animated: (BOOL)animated
                   completion:(void (^)(void))completion{
    __weak typeof(self) weakSelf = self;
    if(self.rootNavigationController.presentedViewController){
        [self.rootNavigationController dismissViewControllerAnimated:NO completion:^{
            [weakSelf.rootNavigationController presentViewController:viewControllerToPresent
                                                            animated:animated
                                                          completion:^{
                                                              completion();
                                                          }];
        }];
    }else{
        [self.rootNavigationController presentViewController:viewControllerToPresent
                                                    animated:animated
                                                  completion:^{
                                                      completion();
                                                  }];
    }
}

- (void)dismissViewControllerAnimated: (BOOL) animated
                           completion: (void (^)(void))completion
{
    if(self.rootNavigationController.presentedViewController){
        [self.rootNavigationController dismissViewControllerAnimated:animated
                                                          completion:^{
                                                              completion();
                                                          }];
    }
}


#pragma mark --
#pragma mark XNavigationControllerDelegate
- (void) navigationControllerChange:(UIViewController *) currentViewController{
    if(currentViewController){
        if([currentViewController isKindOfClass:[XTabBarController class]]){
            XTabBarController *tabBarController = (XTabBarController*)currentViewController;
            UIViewController *viewController = [tabBarController tabBarControllerWithIndex:tabBarController.selectedIndex];
            if(viewController && [viewController isKindOfClass:[UINavigationController class]]){
                UINavigationController *navigationController = (UINavigationController*)viewController;
                self.tabCurrentController = [navigationController topViewController];
            }else{
                self.tabCurrentController = viewController;
            }
        }else{
            
        }
    }
}

#pragma mark --
#pragma mark TabBarControllerDelegate
- (void) tabBarControllerChange:(XTabBarController *) tabBarController{
    if(tabBarController && [tabBarController isKindOfClass:[XTabBarController class]]){
        UIViewController *viewController = [tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex];
        if(viewController){
            if([viewController isKindOfClass:[UINavigationController class]]){
                UINavigationController *navigationController = (UINavigationController*)viewController;
                self.tabCurrentController = [navigationController topViewController];
            }else{
                self.tabCurrentController = viewController;
            }
        }
    }
}

- (void) tabBarControllerReChooie:(XTabBarController *) tabBarController{
    //tabBar被重新点击，一般会伴随有对应的事件
}

@end
