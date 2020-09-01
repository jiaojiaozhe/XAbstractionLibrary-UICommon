//
//  AIListHeadView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 ToC项目滑动列表默认头部
 */
@interface AIListHeadView : XBaseListHeadView

/**
 创建滑动列表默认头部

 @return 返回滑动列表默认头部
 */
+ (AIListHeadView *) createHeadView;
@end
