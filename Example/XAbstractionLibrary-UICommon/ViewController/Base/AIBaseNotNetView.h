//
//  AIBaseNotNetView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 ToC项目的无网错误页
 */
@interface AIBaseNotNetView : UIView<XIBaseNotNetViewDelegate>

/**
 *  无网重试代理
 */
@property (nonatomic,weak) id<XIBaseNoNetViewRetryDelegate> retryDelegate;

/**
 ToC项目的无网错误页

 @return 返回无网错误页
 */
+ (id<XIBaseNotNetViewDelegate>) createNotNetView;
@end
