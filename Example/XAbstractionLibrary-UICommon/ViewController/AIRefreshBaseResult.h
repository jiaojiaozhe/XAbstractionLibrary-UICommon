//
//  AIRefreshBaseResult.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/25.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "AIBaseModel.h"
#import "AIBaseResult.h"

@interface AIRefreshBaseResult : AIBaseResult

- (NSArray<AIBaseModel> *) getDataList;
@end
