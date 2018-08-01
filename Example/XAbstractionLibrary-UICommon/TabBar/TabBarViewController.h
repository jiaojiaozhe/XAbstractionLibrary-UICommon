//
//  TabBarViewController.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

@interface TabBarViewController : XTabBarController
@property (nonatomic,weak) id<XTabBarControllerDelegate> tabBarDelegate;
@end
