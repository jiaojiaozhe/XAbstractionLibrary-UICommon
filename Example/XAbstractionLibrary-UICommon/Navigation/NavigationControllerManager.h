//
//  NavigationControllerManager.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "NavigationController.h"
#import "TabBarViewController.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface NavigationControllerManager : XData<XNavigationControllerDelegate,TabBarControllerDelegate>

+ (instancetype) sharePageManager;

- (NavigationController *) rootNavigationController;

- (void) pushViewControllerOnTab:(UIViewController *) controller
                        animated:(BOOL) animated;

- (void) pushViewControllerOnMain:(UIViewController *)controller
                         animated:(BOOL)animated;
@end
