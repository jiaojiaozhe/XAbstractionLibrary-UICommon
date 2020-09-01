//
//  AIListFootView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 ToC项目滑动列表默认底部
 */
@interface AIListFootView : XBaseListFootView

/**
 构建滑动列表默认底部

 @return 返回滑动列表默认底部
 */
+ (AIListFootView *) createFootView;
@end
