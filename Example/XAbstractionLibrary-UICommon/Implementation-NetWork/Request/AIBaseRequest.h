//
//  AIBaseRequest.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseModel.h"
#import "AIBaseRequestHeader.h"

/**
 基础请求对象
 */
@interface AIBaseRequest : AIBaseModel

/**
 接口名
 */
@property (nonatomic,strong) NSString *command;


/**
 接口请求头
 */
@property (nonatomic,strong) AIBaseRequestHeader *header;
@end
