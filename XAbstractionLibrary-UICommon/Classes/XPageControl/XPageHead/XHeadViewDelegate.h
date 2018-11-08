//
//  XHeadViewDelegate.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/11/8.
//

#ifndef XHeadViewDelegate_h
#define XHeadViewDelegate_h

/**
 头部回调代理
 */
@protocol XHeadViewDelegate<NSObject>

/**
 设定头部左区域，业务设定
 */
- (UIView *) getHeadLeftView;

/**
 设定头部右区域
 */
- (UIView *) getHeadRightView;

/**
 设定头部中间区域
 */
- (UIView *) getHeadCenterView;
@end

#endif /* XHeadViewDelegate_h */
