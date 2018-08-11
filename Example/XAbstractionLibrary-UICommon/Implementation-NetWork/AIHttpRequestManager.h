//
//  AIHttpRequestManager.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseHttpRequestManager.h"


/**
 ToC的http请求管理器
 */
@interface AIHttpRequestManager : AIBaseHttpRequestManager

/**
 *  获取http管理器单例
 */
+ (instancetype) shareHttpRequestManager;

@end
