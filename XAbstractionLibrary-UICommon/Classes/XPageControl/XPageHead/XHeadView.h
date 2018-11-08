//
//  XHeadView.h
//  AIParkSJZ
//
//  Created by lanbiao on 2018/8/16.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

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

/**
 navigationBar
 */
@interface XHeadView : UIView

@property (nonatomic,weak) id<XHeadViewDelegate> delegate;

/**
 构建导航头

 @return 返回导航头
 */
+ (XHeadView *) createHeadViewWithDelegate:(id<XHeadViewDelegate>) delegate;

@end
