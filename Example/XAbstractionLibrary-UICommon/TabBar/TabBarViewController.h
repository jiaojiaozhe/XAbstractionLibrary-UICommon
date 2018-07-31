//
//  TabBarViewController.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

@protocol TabBarControllerDelegate <NSObject>
@optional
/**
 *  选中item回调对应的controller，与tabBarControllerReChooie只会有一个会被调用
 *
 *  @param tabBarController tabBar控制器
 */
- (void) tabBarControllerChange:(XTabBarController *) tabBarController;

/**
 *  重复选中回调,与tabBarControllerChange只会有一个会被调用
 */
- (void) tabBarControllerReChooie:(XTabBarController *) tabBarController;
@end

@interface TabBarViewController : XTabBarController
@property (nonatomic,weak) id<TabBarControllerDelegate> tabBarDelegate;
@end
