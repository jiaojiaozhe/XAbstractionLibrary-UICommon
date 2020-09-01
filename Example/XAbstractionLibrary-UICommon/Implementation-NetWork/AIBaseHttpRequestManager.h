//
//  AIBaseHttpRequestManager.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseResult.h"
#import "AIBaseRequest.h"
#import <XAbstractionLibrary_NetWork/XAbstractionLibrary-NetWork-umbrella.h>


/**
 接口请求的业务回调

 @param request 当前请求对象
 @param result 请求结果的解析对象
 @param resultDic 请求结果的原始数据
 */
typedef void(^ResultBlock)(id<XHttpRequestDelegate> request,AIBaseResult *result,id resultDic);

/**
 接口请求的数据有效性回调，业务实现

 @param request 当前请求对象
 @param result 请求结果的解析对象
 @param resultDic 请求结果的原始数据
 @return YES数据有效 否则无效
 */
typedef BOOL(^ExistsDataBlock)(id<XHttpRequestDelegate> request,AIBaseResult *result,id resultDic);

/**
 基础http请求管理器，抽象类
 */
@interface AIBaseHttpRequestManager : XBaseHttpRequestManager

/**
 *  接口请求主机地址
 */
@property (nonatomic,strong) NSString *httpHostAddress;

/**
 *  get请求
 *
 *  @param command              接口请求名
 *  @param requestParams        接口请求参数集合
 *  @param delegate             接口请求回调代理
 *  @param resultClass          接口请求结果解析的数据类型
 *  @param resultBlock          接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                                      httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       resultClass:(Class) resultClass
                                       resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;


/**
 *  get请求,公共参数放在header中
 *
 *  @param command              接口请求名
 *  @param requestParams        接口请求私有参数集合
 *  @param requestHeaderParams  接口共有参数集合
 *  @param delegate             接口请求回调代理
 *  @param resultClass          接口请求结果解析的数据类型
 *  @param resultBlock          接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                               requestHeaderParams:(NSDictionary *) requestHeaderParams
                                      httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       resultClass:(Class) resultClass
                                       resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;

/**
 get请求，公共参数在header

 @param request 接口请求参数对象
 @param delegate 接口请求状态代理
 @param resultClass 接口请求结果对象
 @param resultBlock 接口请求业务回调
 @return 返回请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithRequest:(AIBaseRequest *) request
                                      httpDelegate:(id<XHttpResponseDelegate>)delegate
                                       resultClass:(__unsafe_unretained Class)resultClass
                                       resultBlock:(ResultBlock)resultBlock DEPRECATED_ATTRIBUTE;


/**
 *  get请求
 *
 *  @param command              接口请求名
 *  @param requestParams        接口请求参数集合
 *  @param resultClass          接口请求结果解析的数据类型
 *  @param resultBlock          接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                                       resultClass:(Class) resultClass
                                       resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;


/**
 *  get请求,公共参数放在header中
 *
 *  @param command              接口请求名
 *  @param requestParams        接口请求私有参数集合
 *  @param requestHeaderParams  接口共有参数集合
 *  @param resultClass          接口请求结果解析的数据类型
 *  @param resultBlock          接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                               requestHeaderParams:(NSDictionary *) requestHeaderParams
                                       resultClass:(Class) resultClass
                                       resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;

/**
 get请求，公共参数在header
 
 @param request 接口请求参数对象
 @param resultClass 接口请求结果对象
 @param resultBlock 接口请求业务回调
 @return 返回请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithRequest:(AIBaseRequest *) request
                                       resultClass:(__unsafe_unretained Class)resultClass
                                       resultBlock:(ResultBlock)resultBlock;

/**
 *  post请求
 *
 *  @param command          接口请求名
 *  @param postParams       接口请求参数集合
 *  @param resultClass      接口请求结果解析的数据类型
 *  @param resultBlock      接口请求业务回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *) command
                                         postParams:(NSDictionary *) postParams
                                        resultClass:(Class) resultClass
                                        resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;

/**
 *  post请求，公共参数放在header中
 *
 *  @param command                  接口请求名
 *  @param postParams               接口请求参数集合
 *  @param postHeaderParams         接口请求header集合
 *  @param resultClass              接口请求结果解析的数据类型
 *  @param resultBlock              接口请求业务回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *) command
                                         postParams:(NSDictionary *) postParams
                                   postHeaderParams:(NSDictionary *) postHeaderParams
                                        resultClass:(Class) resultClass
                                        resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;


/**
 post请求，公共参数在header中
 
 @param request 请求参数对象集合
 @param resultClass 请求结果解析的数据类型
 @param resultBlock 请求结果业务回调
 @return 返回当前请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock;


/**
 *  post请求
 *
 *  @param command          接口请求名
 *  @param postParams       接口请求参数集合
 *  @param delegate         接口请求代理
 *  @param resultClass      接口请求结果解析的数据类型
 *  @param resultBlock      接口请求业务回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *) command
                                         postParams:(NSDictionary *) postParams
                                       httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        resultClass:(Class) resultClass
                                        resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;

/**
 *  post请求，公共参数放在header中
 *
 *  @param command                  接口请求名
 *  @param postParams               接口请求参数集合
 *  @param postHeaderParams         接口请求header集合
 *  @param delegate                 接口请求代理
 *  @param resultClass              接口请求结果解析的数据类型
 *  @param resultBlock              接口请求业务回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *) command
                                         postParams:(NSDictionary *) postParams
                                   postHeaderParams:(NSDictionary *) postHeaderParams
                                       httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        resultClass:(Class) resultClass
                                        resultBlock:(ResultBlock) resultBlock DEPRECATED_ATTRIBUTE;


/**
 post请求，公共参数在header中

 @param request 请求参数对象集合
 @param delegate 请求状态代理
 @param resultClass 请求结果解析的数据类型
 @param resultBlock 请求结果业务回调
 @return 返回当前请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock DEPRECATED_ATTRIBUTE;
@end
