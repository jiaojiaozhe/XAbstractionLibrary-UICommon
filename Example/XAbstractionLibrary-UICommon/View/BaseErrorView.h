//
//  BaseErrorView.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 *  基础errorView
 */
@interface BaseErrorView : UIView<XIBaseErrorViewDelegate>

/**
 *  重试代理对象
 */
@property (nonatomic,weak) id<XIBaseRetryDelegate> retryDelegate;

/**
 *  初始化view
 */
- (void) initView;

/**
 *  构建errorView
 */
+ (id<XIBaseErrorViewDelegate>) createErrorView;
@end
