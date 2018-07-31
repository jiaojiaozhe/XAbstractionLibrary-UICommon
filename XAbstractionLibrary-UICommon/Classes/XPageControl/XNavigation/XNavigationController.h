//
//  XNavigationController.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/30.
//

#import <UIKit/UIKit.h>

/**
 *  页面栈顶发生变化时的代理
 */
@protocol XNavigationControllerDelegate <NSObject>

/**
 *  页面栈顶发生变化时的回调
 *  @param currentViewController 当前栈顶的控制器
 */
- (void) navigationControllerChange:(UIViewController *) currentViewController;
@end

/**
 *  created by lanbiao on 2018/07/30
 *  基础导航控制器，不支持UIViewController自动扩展到状态栏/导航栏/UITabBar之下，属于中规中矩的操作，并且提供了一些其它的基础功能
 *  1、只支持竖向，不支持其它方向。
 */
@interface XNavigationController : UINavigationController<UINavigationControllerDelegate>

/**
 *  页面变化回调代理
 */
@property (nonatomic,weak) id<XNavigationControllerDelegate> currentNavigationDelegate;

@end
