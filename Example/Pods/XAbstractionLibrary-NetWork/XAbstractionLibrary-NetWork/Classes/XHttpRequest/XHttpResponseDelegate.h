//
//  XHttpResponseDelegate.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/12.
//

#import <Foundation/Foundation.h>

@protocol XHttpRequestDelegate;
typedef void(^XResponseBlock)(id<XHttpRequestDelegate> httpRequest,id responseObj,NSError *error);

/**
 *  请求状态回调代理
 */
@protocol XHttpResponseDelegate <NSObject>

/**
 *  取消请求
 */
- (void) cancelRequest:(id<XHttpRequestDelegate>) request;

/**
 *  即将开始准备请求
 *
 *  @param request 请求对象
 */
- (void) willStartRequest:(id<XHttpRequestDelegate>) request;

/**
 *  请求重试
 *
 *  @param oldRequest   旧的请求对象
 *  @param newRequest   新的请求对象
 */
- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest;

/**
 *  请求进度回调
 *
 *  @param request 请求对象
 *  @param progress 请求进度
 *  @param totalProgress    总的进度
 */
- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress;

/**
 *  请求完成
 *
 *  @param  request 请求对象
 *  @param  responseDic 请求结果
 *  @param  error   请求错误，如果有的话，否则nil
 */
- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error;
@end
