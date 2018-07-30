//
//  XView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <UIKit/UIKit.h>
#import "XAbstractView.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

/**
*   created by lanbiao on 2018/07/20
 *  抽象化view,包含错误、无网、空数据、加载中等的异常处理
 */
@interface XView : UIView<XAbstractView>

/**
 *  获得模板xview
 */
+ (XView *) createView;

/**
 *  获取内容区
 */
- (UIView *) getContentView;
@end
