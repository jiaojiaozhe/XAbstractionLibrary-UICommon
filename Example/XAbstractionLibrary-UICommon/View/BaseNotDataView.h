//
//  BaseNotDataView.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 *  基础无数据view
 */
@interface BaseNotDataView : UIView<XIBaseNotDataViewDelegate>

/**
 *  无数据重试代理
 */
@property (nonatomic,weak) id<XIBaseNotDataRetryDelegate> retryDelegate;

/**
 *  构建无数据view
 */
+ (id<XIBaseNotDataViewDelegate>) createNotDataView;

@end
