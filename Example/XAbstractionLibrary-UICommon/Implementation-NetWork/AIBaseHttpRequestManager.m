//
//  AIBaseHttpRequestManager.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIAES.h"
#import "AIJSONAdapter.h"
#import "AIBaseRequest.h"
#import "AIResolveResult.h"
#import "AIBaseHttpRequestManager.h"

@implementation AIBaseHttpRequestManager

- (NSString *) getRequestUrlWithCommand:(NSString *) command{
    NSString *requestUrl = [[NSURL URLWithString:command
                                   relativeToURL:[NSURL URLWithString:self.httpHostAddress]] absoluteString];
    return requestUrl;
}

- (NSMutableDictionary *) addDefaultParams:(NSDictionary *) params{
    NSMutableDictionary *defaultParams = NULL;
    if(!params){
        defaultParams = [NSMutableDictionary dictionary];
    }else{
        defaultParams = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    
    DICT_PUT(defaultParams, @"key1", @"value1");
    DICT_PUT(defaultParams, @"key2", @"value2");
    return defaultParams;
}

- (NSMutableDictionary *) addDefaultHeaderParams:(NSDictionary *) headerParams{
    NSMutableDictionary *defaultHeaderParams = NULL;
    if(!headerParams){
        defaultHeaderParams = [NSMutableDictionary dictionary];
    }else{
        defaultHeaderParams = [NSMutableDictionary dictionaryWithDictionary:headerParams];
    }
    
    DICT_PUT(defaultHeaderParams, @"headerKey1", @"headerValue1");
    DICT_PUT(defaultHeaderParams, @"headerKey2", @"headerValue2");
    return defaultHeaderParams;
}

- (void) requestCallBack:(id<XHttpRequestDelegate>) httpRequest
             resultClass:(Class) resultClass
             responseObj:(id) responseObj
                   error:(NSError *) error
             resultBlock:(ResultBlock) resultBlock{
    //暂时测试start
    if(responseObj && ![responseObj isKindOfClass:[NSDictionary class]]){
        responseObj = [AIAES decryptAES:responseObj key:@"41d8a6040c60c4c5"];
    }
    //暂时测试end
    
    AIBaseResult *result = [AIResolveResult resolveWithClass:resultClass
                                                   resultObj:responseObj
                                                       error:error];
    if([result isSuccess]){
        
    }else{
        //有其他需求，可以扩展
    }
    
    if(resultBlock){
        resultBlock(httpRequest,result,responseObj);
    }
}

- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                                      httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       resultClass:(__unsafe_unretained Class)resultClass
                                       resultBlock:(ResultBlock) resultBlock{
    return [self getRequestWithCommand:command
                         requestParams:requestParams
                   requestHeaderParams:NULL
                          httpDelegate:delegate
                           resultClass:resultClass
                         resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *)command
                                     requestParams:(NSDictionary *)requestParams
                               requestHeaderParams:(NSDictionary *)requestHeaderParams
                                      httpDelegate:(id<XHttpResponseDelegate>)delegate
                                       resultClass:(__unsafe_unretained Class)resultClass
                                       resultBlock:(ResultBlock)resultBlock{
    NSString *urlString = [self getRequestUrlWithCommand:command];
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    if([requestParams count] > 0){
        NSString *postParamString = [AIJSONAdapter objectToJson:requestParams];
        NSString *aesString = [AIAES encryptAES:postParamString key:@"41d8a6040c60c4c5"];
        DICT_PUT(requestDic, @"param", aesString);
    }
    
    __weak typeof(self) weakSelf = self;
    return [self getRequestWithUrlString:urlString
                           requestParams:[self addDefaultParams:requestDic]
                     requestHeaderParams:[self addDefaultHeaderParams:requestHeaderParams]
                            httpDelegate:delegate
                           responseblock:^(id<XHttpRequestDelegate> httpRequest, id responseObj, NSError *error) {
                               [weakSelf requestCallBack:httpRequest
                                             resultClass:resultClass
                                             responseObj:responseObj
                                                   error:error
                                             resultBlock:resultBlock];
                           }];
}

- (id<XHttpRequestDelegate>) getRequestWithRequest:(AIBaseRequest *) request
                                      httpDelegate:(id<XHttpResponseDelegate>)delegate
                                       resultClass:(__unsafe_unretained Class)resultClass
                                       resultBlock:(ResultBlock)resultBlock{
    NSString *command = [request command];
    NSDictionary *requestParams = [AIJSONAdapter JSONDictionaryFromModel:request
                                                                   error:nil];
    NSDictionary *requestHeaderParams = [AIJSONAdapter JSONDictionaryFromModel:[request header]
                                                                         error:nil];
    return [self getRequestWithCommand:command
                         requestParams:requestParams
                   requestHeaderParams:requestHeaderParams
                          httpDelegate:delegate
                           resultClass:resultClass
                           resultBlock:resultBlock];
}


- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                                       resultClass:(Class) resultClass
                                       resultBlock:(ResultBlock) resultBlock{
    return [self getRequestWithCommand:command
                         requestParams:requestParams
                          httpDelegate:NULL
                           resultClass:resultClass
                           resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) getRequestWithCommand:(NSString *) command
                                     requestParams:(NSDictionary *) requestParams
                               requestHeaderParams:(NSDictionary *) requestHeaderParams
                                       resultClass:(Class) resultClass
                                       resultBlock:(ResultBlock) resultBlock{
    return [self getRequestWithCommand:command
                         requestParams:requestParams
                   requestHeaderParams:requestHeaderParams
                          httpDelegate:NULL
                           resultClass:resultClass
                           resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) getRequestWithRequest:(AIBaseRequest *) request
                                       resultClass:(__unsafe_unretained Class)resultClass
                                       resultBlock:(ResultBlock)resultBlock{
    return [self getRequestWithRequest:request
                          httpDelegate:NULL
                           resultClass:resultClass
                           resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *) command
                                         postParams:(NSDictionary *) postParams
                                        resultClass:(Class) resultClass
                                        resultBlock:(ResultBlock) resultBlock{
    return [self postRequestWithCommand:command
                             postParams:postParams
                           httpDelegate:NULL
                            resultClass:resultClass
                            resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *) command
                                         postParams:(NSDictionary *) postParams
                                   postHeaderParams:(NSDictionary *) postHeaderParams
                                        resultClass:(Class) resultClass
                                        resultBlock:(ResultBlock) resultBlock{
    return [self postRequestWithCommand:command
                             postParams:postParams
                       postHeaderParams:postHeaderParams
                           httpDelegate:NULL
                            resultClass:resultClass
                            resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock{
    return [self postRequestWithRequest:request
                           httpDelegate:NULL
                            resultClass:resultClass
                            resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *)command
                                         postParams:(NSDictionary *)postParams
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock{
    return [self postRequestWithCommand:command
                             postParams:postParams
                       postHeaderParams:NULL
                           httpDelegate:delegate
                            resultClass:resultClass
                          resultBlock:resultBlock];
}

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *)command
                                         postParams:(NSDictionary *)postParams
                                   postHeaderParams:(NSDictionary *)postHeaderParams
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock{
    NSString *urlString = [self getRequestUrlWithCommand:command];
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    if([postParams count] > 0){
        NSString *postParamString = [AIJSONAdapter objectToJson:postParams];
        NSString *aesString = [AIAES encryptAES:postParamString key:@"41d8a6040c60c4c5"];
        DICT_PUT(requestDic, @"param", aesString);
    }
    
    __weak typeof(self) weakSelf = self;
    return [self postRequestWithUrlString:urlString
                               postParams:[self addDefaultParams:requestDic]
                         postHeaderParams:[self addDefaultHeaderParams:postHeaderParams]
                             httpDelegate:delegate
                            responseblock:^(id<XHttpRequestDelegate> httpRequest, id responseObj, NSError *error) {
                                [weakSelf requestCallBack:httpRequest
                                              resultClass:resultClass
                                              responseObj:responseObj
                                                    error:error
                                              resultBlock:resultBlock];
                            }];
}

- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock{
    NSString *command = [request command];
    NSDictionary *requestParams = [AIJSONAdapter JSONDictionaryFromModel:request
                                                                   error:nil];
    NSDictionary *requestHeaderParams = [AIJSONAdapter JSONDictionaryFromModel:request
                                                                         error:nil];
    return [self postRequestWithCommand:command
                             postParams:requestParams
                       postHeaderParams:requestHeaderParams
                           httpDelegate:delegate
                            resultClass:resultClass
                            resultBlock:resultBlock];
}

@end
