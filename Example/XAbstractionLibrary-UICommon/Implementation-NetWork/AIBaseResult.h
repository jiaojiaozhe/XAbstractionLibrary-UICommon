//
//  AIBaseResult.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary_Parse/XAbstractionLibrary-Parse-umbrella.h>


/**
 ToC接口的基础result模型,所有接口模型继承自它
 */
@interface AIBaseResult : XBaseModel<XResult>

/**
 请求错误码,服务端返回
 */
@property (nonatomic,assign) NSInteger errorCode;

/**
 请求错误提示语，服务端返回
 */
@property (nonatomic,strong) NSString *serverMsg;

/**
 构建请求成功结果

 @return 返回成功结果
 */
+ (AIBaseResult *) createSuccess;


/**
 构建请求超时结果

 @return 返回超时结果
 */
+ (AIBaseResult *) createTimerout;

/**
 构建请求未知错误

 @return 返回请求未知错误
 */
+ (AIBaseResult *) createOtherError;
@end
