//
//  AIBaseErrorView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 Toc项目加载错误页
 */
@interface AIBaseErrorView : UIView<XIBaseErrorViewDelegate>

/**
 *  重试代理对象
 */
@property (nonatomic,weak) id<XIBaseRetryDelegate> retryDelegate;

/**
 *  初始化view
 */
- (void) initView;

/**
 构建ToC项目加载错误页

 @return 返回加载错误页
 */
+ (id<XIBaseErrorViewDelegate>) createErrorView;
@end
