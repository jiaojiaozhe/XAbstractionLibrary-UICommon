//
//  BaseNotNetView.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 *  基础无网view
 */
@interface BaseNotNetView : UIView<XIBaseNotNetViewDelegate>

/**
 *  构建无网view
 */
+ (id<XIBaseNotNetViewDelegate>) createNotNetView;

/**
 *  无网重试代理
 */
@property (nonatomic,weak) id<XIBaseNoNetViewRetryDelegate> retryDelegate;

@end
