//
//  AIBaseLoadingView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 ToC项目的基础加载view
 */
@interface AIBaseLoadingView : UIView<XIBaseLoadingViewDelegate>

/**
 构建ToC项目的加载状态页

 @return 返回加载状态页
 */
+ (id<XIBaseLoadingViewDelegate>) createLoadingView;
@end
