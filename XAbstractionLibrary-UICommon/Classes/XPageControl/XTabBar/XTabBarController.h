//
//  XTabBarController.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/30.
//

#import <UIKit/UIKit.h>

@class XTabBarController;


/**
 tabBarItem的点击事件回调代理
 */
@protocol XTabBarControllerDelegate <NSObject>
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

/**
 自定义基础tabBarController
 */
@interface XTabBarController : UITabBarController

/**
 tabBarItem事件回调代理
 */
@property (nonatomic,weak) id<XTabBarControllerDelegate> tabBarDelegate;

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
