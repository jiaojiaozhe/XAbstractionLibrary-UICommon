//
//  AIBaseNotDataView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 ToC项目无数据页
 */
@interface AIBaseNotDataView : UIView<XIBaseNotDataViewDelegate>

/**
 *  无数据重试代理
 */
@property (nonatomic,weak) id<XIBaseNotDataRetryDelegate> retryDelegate;

/**
 构建ToC项目的无数据页

 @return 返回无数据页
 */
+ (id<XIBaseNotDataViewDelegate>) createNotDataView;
@end
