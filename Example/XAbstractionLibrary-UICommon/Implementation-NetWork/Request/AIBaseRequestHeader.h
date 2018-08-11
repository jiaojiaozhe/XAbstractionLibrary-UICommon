//
//  AIBaseRequestHeader.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseModel.h"

/**
 接口请求头
 */
@interface AIBaseRequestHeader : AIBaseModel

/**
 操作系统版本
 */
@property (nonatomic,strong) NSString *osVersion;

/**
 app版本
 */
@property (nonatomic,strong) NSString *version;

/**
 接口请求来源
 */
@property (nonatomic,strong) NSString *source;

/**
 渠道号
 */
@property (nonatomic,strong) NSString *channel;

/**
 设备唯一标识
 */
@property (nonatomic,strong) NSString *clientID;

/**
 设备型号
 */
@property (nonatomic,strong) NSString *device;

/**
 请求时间
 */
@property (nonatomic,assign) double requestTime;

/**
 mac地址
 */
@property (nonatomic,strong) NSString *devmac;

/**
 厂商
 */
@property (nonatomic,strong) NSString *manufacturer;
@end
