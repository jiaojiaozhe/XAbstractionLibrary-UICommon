//
//  UIViewController+PushTransistion.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/31.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef enum {
    //拖动模式
    PushTransitionGestureRecognizerTypePan,
    //边界拖动模式
    PushTransitionGestureRecognizerTypeScreenEdgePan,
} PushTransitionGestureRecognizerType;

/**
 created by lanbiao on 2018/07/31
 对视图控制器侧滑拖动的支持
 */
@interface UIViewController (PushTransistion)

/**
 *  关联手势推入推出，并且指定模式
 *
 *  @param type 边缘或全域
 */
+ (void)validatePanWithPushTransitionGestureRecognizerType:(PushTransitionGestureRecognizerType)type;

/**
 *  设置当前页面是否支持滑动
 *
 *  @param bStop YES关闭 否则打开
 */
- (void) setBStopDrag:(BOOL) bStop;
@end
