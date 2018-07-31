//
//  XTabBarController.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/30.
//

#import <UIKit/UIKit.h>

@class XTabBarController;

/**
 自定义基础tabBarController
 */
@interface XTabBarController : UITabBarController

/**
 *  tabBar的高度，默认就是系统高度
 */
- (CGFloat) tabBarHeight;

/**
 *  自定义tabBar
 */
- (XTabBar *) tabBarView;

/**
 *  自定义tabBar对应的controller集合
 */
- (NSArray *) tabBarViewControllers;

/**
 *  获取index位置的viewController
 */
- (UIViewController *) tabBarControllerWithIndex:(NSInteger) index;

@end
