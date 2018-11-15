//
//  AIBaseView.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseRequest.h"
#import "AIHttpRequestManager.h"
#import "AIHttpsRequestManager.h"
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

/**
 ToC项目的基础View，非常重要，天然支持了无网、加载中、加载错误、无数据等状态的支持
 */
@interface AIBaseView : XView

/**
 页面级的post请求方法

 @param request 请求参数对象
 @param delegate 请求过程中的代理回调
 @param resultClass 请求结果需要解析的类型
 @param resultBlock 请求结果业务回调
 @param existsDataBlock 请求结果判断是否无数据，不是必须实现
 @return 返回当前post请求的对象
 */
- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock;

/**
 页面级的post请求方法

 @param command 接口请求名
 @param postParams 接口请求参数
 @param postHeaderParams 接口请求头参数
 @param delegate 请求过程中的代理回调
 @param resultClass 请求结果需要解析的类型
 @param resultBlock 请求结果业务的回调
 @param existsDataBlock 请求结果判断是否无数据，不是必须实现
 @return 返回当前post请求的对象
 */
- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *)command
                                         postParams:(NSDictionary *)postParams
                                   postHeaderParams:(NSDictionary *)postHeaderParams
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock;

@end
