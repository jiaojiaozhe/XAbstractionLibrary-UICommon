//
//  AIHttpsRequestManager.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseHttpRequestManager.h"

/**
 ToC的https请求管理器
 */
@interface AIHttpsRequestManager : AIBaseHttpRequestManager

/**
 *  获取https单例请求管理器
 */
+ (instancetype) shareHttpsRequestManager;

@end
