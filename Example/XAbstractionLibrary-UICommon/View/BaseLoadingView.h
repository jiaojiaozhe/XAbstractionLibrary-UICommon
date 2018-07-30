//
//  BaseLoadingView.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 *  基础加载进度view
 */
@interface BaseLoadingView : UIView<XIBaseLoadingViewDelegate>

/**
 *  构建loadingView
 */
+ (id<XIBaseLoadingViewDelegate>) createLoadingView;
@end
