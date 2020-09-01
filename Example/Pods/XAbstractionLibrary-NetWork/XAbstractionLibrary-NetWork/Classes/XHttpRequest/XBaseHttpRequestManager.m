//
//  XBaseHttpRequestManager.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/12.
//

#import "AFNetworking.h"
#import "XBaseHttpRequest.h"
#import "XBaseUploadHttpRequest.h"
#import "XBaseHttpRequestManager.h"
#import "XBaseDownloadHttpRequest.h"

@interface XBaseHttpRequestManager()
@property (nonatomic,strong) XLock *lock;
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic,strong) NSMutableDictionary *allRequests;
@property (nonatomic,strong) NSMutableDictionary *allAuthRequests;
@end

@implementation XBaseHttpRequestManager

- (instancetype) init{
    if(self = [super init]){
        _lock = [[XLock alloc] init];
        _allRequests = [NSMutableDictionary dictionary];
        _allAuthRequests = [NSMutableDictionary dictionary];
        _sessionManager = [AFHTTPSessionManager manager];
        RequestSerializerType requestSerializerType =[self getRequestSerializerType];
        if(requestSerializerType == RequestSerializerTypeUnknown){
            
        }else if(requestSerializerType == RequestSerializerTypeHTTP){
            [_sessionManager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        }else if(requestSerializerType == RequestSerializerTypePropertyList){
            [_sessionManager setRequestSerializer:[AFPropertyListRequestSerializer serializer]];
        }else if(requestSerializerType == RequestSerializerTypeJSON){
            [_sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        }else{
            [_sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        }
        
        [_sessionManager.requestSerializer setTimeoutInterval:[self timeOut]];
        
        
        ResponseSerializerType responseSerializerType = [self getResponseSerializerType];
        if(responseSerializerType == ResponseSerializerTypeUnknown ||
           responseSerializerType == ResponseSerializerTypeJSON){
            _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        }else if(responseSerializerType == ResponseSerializerTypeHTTP){
            _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }else if(responseSerializerType == ResponseSerializerTypeImage){
            _sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
        }else if(responseSerializerType == ResponseSerializerTypeXMLParse){
            _sessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        }else if(responseSerializerType == ResponseSerializerTypePropertyList){
            _sessionManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
        }else{
            _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        [_sessionManager.responseSerializer setAcceptableContentTypes:[self getAcceptableContentTypes]];
    }
    return self;
}

- (NSTimeInterval) timeOut{
    return 20;
}

- (RequestSerializerType) getRequestSerializerType{
    return RequestSerializerTypeUnknown;
}

- (ResponseSerializerType) getResponseSerializerType{
    return ResponseSerializerTypeJSON;
}

- (NSSet*) getAcceptableContentTypes{
    return [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
}


/**
 添加新的请求到集合

 @param request 待添加的请求对象
 @return YES 表示确实需要发出请求  否则不需要发起请求，等待回调就好
 */
- (BOOL) appendRequest:(id<XHttpRequestDelegate>) request{
    BOOL bNeedReuqest = NO;
    if(request == NULL){
        return bNeedReuqest;
    }
    
    if([request isKindOfClass:[XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest *)request;
        if(httpRequest.ID.length <= 0 || httpRequest.authID.length <= 0){
            return bNeedReuqest;
        }
        
        @synchronized(_lock){
            if(![_allRequests.allKeys containsObject:httpRequest.ID]){
                [_allRequests setObject:httpRequest forKey:httpRequest.ID];
            }
            
            NSMutableDictionary *authHttpRequests = nil;
            if([_allAuthRequests.allKeys containsObject:httpRequest.authID]){
                authHttpRequests = [_allAuthRequests objectForKey:httpRequest.authID];
            }
            
            if(!authHttpRequests){
                authHttpRequests = [NSMutableDictionary dictionary];
                bNeedReuqest = YES;
            }
            
            [authHttpRequests setObject:httpRequest forKey:httpRequest.ID];
            [_allAuthRequests setObject:authHttpRequests forKey:httpRequest.authID];
        }
    }
    return bNeedReuqest;
}

/**
 从请求集合中移除请求

 @param request 待移除的请求对象
 */
- (void) removeRequest:(id<XHttpRequestDelegate>) request{
    if(!request){
        return;
    }
    
    if([request isKindOfClass: [XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
        if(httpRequest.ID.length <= 0 || httpRequest.ID.length <= 0){
            return;
        }
        
        @synchronized(_lock){
            if([_allRequests.allKeys containsObject:httpRequest.ID]){
                [_allRequests removeObjectForKey:httpRequest.ID];
            }
            
            NSMutableDictionary *authHttpRequests = nil;
            if([_allAuthRequests.allKeys containsObject:httpRequest.authID]){
                authHttpRequests = [_allAuthRequests objectForKey:httpRequest.authID];
                if(authHttpRequests)
                    [authHttpRequests removeObjectForKey:httpRequest.ID];
            }
            if([authHttpRequests count] <= 0){
                [_allAuthRequests removeObjectForKey:httpRequest.authID];
            }
        }
    }
}


/**
 根据requestID移除request

 @param requestID 请求对象ID
 */
- (void) removeRequestWithID:(NSString *) requestID{
    if([requestID length] <= 0){
        return;
    }
    
    id<XHttpRequestDelegate> request = nil;
    @synchronized(_lock){
        if([_allRequests.allKeys containsObject:requestID]){
            request = [_allRequests objectForKey:requestID];
        }
    }
    
    [self removeRequest:request];
}


/**
 根据请求一致性ID删除请求对象

 @param authID 请求一致性ID
 */
- (void) removeRequestWithAuthID:(NSString *) authID{
    if([authID length] <= 0){
        return ;
    }
    
    NSMutableDictionary *requests = nil;
    @synchronized(_lock){
        if([_allAuthRequests.allKeys containsObject:authID]){
            requests = [_allAuthRequests objectForKey:authID];
        }
    }
    
    int index = (int)[[requests allKeys] count] - 1;
    for(; index >= 0; index--){
        NSString *key = [[requests allKeys] objectAtIndex:index];
        XBaseHttpRequest *httpRequest = [requests objectForKey:key];
        [self removeRequest:httpRequest];
    }
}


/**
 清除所有请求对象
 */
- (void) clearAllRequests{
    @synchronized(_lock){
        [_allRequests removeAllObjects];
        [_allAuthRequests removeAllObjects];
    }
}


/**
 根据请求的各项参数，计算请求一致性ID，并且添加到集合中

 @param method 请求的方法名
 @param requestUrl 请求链接
 @param requestParams 请求的参数
 @param request 本次请求的对象
 @return YES 需要发起实际的请求 否则不用发起，等待回调即可
 */
- (BOOL) processRequestWithMethod:(NSString *) method
                       requestUrl:(NSString *) requestUrl
                    requestParams:(NSDictionary *) requestParams
                          request:(id<XHttpRequestDelegate>) request{
    
    NSMutableString *authKey = [NSMutableString string];
    if([method length] > 0){
        [authKey appendString:method];
    }
    
    if([requestUrl length] > 0){
        [authKey appendString:requestUrl];
    }
    
    NSArray *allKeys = [requestParams allKeys];
    int index = (int)[allKeys count] - 1;
    if(index > 0){
        [authKey appendFormat:@"?"];
    }
    for(;index >= 0; index --){
        NSString *key = [[requestParams allKeys] objectAtIndex:index];
        NSString *value = [requestParams objectForKey:key];
        [authKey appendFormat:@"%@=%@",key,value];
        if(index > 0){
            [authKey appendString:@"&"];
        }
    }
    
    NSString *md5 = [XMD5Digest md5:authKey];
    if(request){
        if([request isKindOfClass:[XBaseHttpRequest class]]){
            XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
            [httpRequest setAuthID:md5];
        }
    }
   return [self appendRequest:request];
}


/**
 请求前必要的一些前置性工作

 @param method 请求方法
 @param urlString 请求链接
 @param requestParams 请求参数集合
 @param requestHeaderParams 请求头参数集合
 @return 返回发起请求必要的请求前置对象
 */
- (NSMutableURLRequest *) createRequestURLWithMethod:(NSString *) method
                                           urlString:(NSString *) urlString
                                       requestParams:(NSDictionary *) requestParams
                                 requestHeaderParams:(NSDictionary *) requestHeaderParams
{
    NSMutableURLRequest *urlRequest = [[_sessionManager requestSerializer] requestWithMethod:method
                                                                                         URLString:urlString
                                                                                        parameters:requestParams
                                                                                             error:nil];
    [urlRequest setTimeoutInterval:[self.sessionManager.requestSerializer timeoutInterval]];
    
    //设置请求头
    NSArray *allKeys = [requestHeaderParams allKeys];
    for(int index = 0 ; index < [allKeys count]; index++){
        NSString *key = [allKeys objectAtIndex:index];
        if(!key)
            continue;
        NSString *value = [requestHeaderParams valueForKey:key];
        if(!value)
            continue;
        [urlRequest setValue:value forHTTPHeaderField:key];
        //[urlRequest addValue:value forHTTPHeaderField:key];
    }
    return urlRequest;
}


/**
 处理即将发起请求的操作

 @param request 即将发起请求的对象
 */
- (void) processRequestStartCallBack:(id<XHttpRequestDelegate>) request{
    
}


/**
 处理请求加载中的操作

 @param request 加载中的对象
 @param progress 当前进度
 @param totalProgress 总的进度
 */
- (void) processRequestLoadingCallBack:(id<XHttpRequestDelegate>) request progress:(long) progress totalProgress:(long) totalProgress{
    if(!request){
        return;
    }
    
    if([request isKindOfClass: [XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*) request;
        if([httpRequest.ID length] <= 0 ||
           [httpRequest.authID length] <= 0){
            return;
        }
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([weakSelf.allAuthRequests.allKeys containsObject:httpRequest.authID]){
                @synchronized(weakSelf.lock){
                    NSMutableDictionary *authRequests = [weakSelf.allAuthRequests objectForKey:httpRequest.authID];
                    NSArray *allValue = [authRequests allValues];
                    int index = (int)[allValue count] - 1;
                    for(; index >= 0; index --){
                        id<XHttpRequestDelegate> request = [allValue objectAtIndex:index];
                        if([request isKindOfClass:[XBaseHttpRequest class]]){
                            XBaseHttpRequest *httpRequest = (XBaseHttpRequest *)request;
                            if([httpRequest respondsToSelector:@selector(execWithRequest:progress:totalProgress:)]){
                                [httpRequest execWithRequest:httpRequest progress:progress totalProgress:totalProgress];
                            }
                        }
                    }
                }
            }
        });
    }
}


/**
 处理重试请求的操作

 @param oldRequest 旧的请求对象
 @param newRequest 新的请求对象
 */
- (void) processRequestRetryCallBack:(id<XHttpRequestDelegate>) oldRequest newRequest:(id<XHttpRequestDelegate>) newRequest{
    if(!oldRequest || !newRequest){
        return;
    }
    
    if([oldRequest isKindOfClass: [XBaseHttpRequest class]] &&
       [newRequest isKindOfClass:[XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*) oldRequest;
        XBaseHttpRequest *newHttpRequest = (XBaseHttpRequest*)newRequest;
        if([httpRequest.ID length] <= 0 ||
           [httpRequest.authID length] <= 0 ||
           [newHttpRequest.ID length] <= 0 ||
           [newHttpRequest.authID length] <= 0){
            return;
        }
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([weakSelf.allAuthRequests.allKeys containsObject:httpRequest.authID]){
                @synchronized(weakSelf.lock){
                    NSMutableDictionary *authRequests = [weakSelf.allAuthRequests objectForKey:httpRequest.authID];
                    NSArray *allValue = [authRequests allValues];
                    int index = (int)[allValue count] - 1;
                    for(; index >= 0; index --){
                        id<XHttpRequestDelegate> request = [allValue objectAtIndex:index];
                        if([request isKindOfClass:[XBaseHttpRequest class]]){
                            XBaseHttpRequest *httpRequest = (XBaseHttpRequest *)request;
                            if([httpRequest respondsToSelector:@selector(willRetryRequest:newRequest:)]){
                                [httpRequest willRetryRequest:httpRequest newRequest:newRequest];
                            }
                        }
                    }
                }
            }
        });
    }
}


/**
 处理请求结果的操作

 @param request 相关的请求对象
 @param responseObject 请求结果
 @param error 错误信息
 */
- (void) processReuqestResultCallBack:(id<XHttpRequestDelegate>) request responseObject:(id) responseObject error:(NSError *) error{
    if(!request){
        return;
    }
    
    if([request isKindOfClass: [XBaseHttpRequest class]]){
        XBaseHttpRequest *httpRequest = (XBaseHttpRequest*) request;
        if([httpRequest.ID length] <= 0 ||
           [httpRequest.authID length] <= 0){
            return;
        }
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([weakSelf.allAuthRequests.allKeys containsObject:httpRequest.authID]){
                @synchronized(weakSelf.lock){
                    NSMutableDictionary *authRequests = [weakSelf.allAuthRequests objectForKey:httpRequest.authID];
                    NSArray *allValue = [authRequests allValues];
                    int index = (int)[allValue count] - 1;
                    for(; index >= 0; index --){
                        id<XHttpRequestDelegate> request = [allValue objectAtIndex:index];
                        if([request isKindOfClass:[XBaseHttpRequest class]]){
                            XBaseHttpRequest *httpRequest = (XBaseHttpRequest *)request;
                            if(httpRequest.responseBlock){
                                httpRequest.responseBlock(httpRequest, responseObject, error);
                            }
                            
                            if([httpRequest respondsToSelector:@selector(completeDidRequest:responseDic:error:)]){
                                [httpRequest completeDidRequest:httpRequest responseDic:responseObject error:error];
                            }
                        }
                    }
                }
                
                if([request isKindOfClass:[XBaseHttpRequest class]]){
                    XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
                    [self removeRequestWithAuthID:httpRequest.authID];
                }
            }
        });
    }
}


- (NSURLSessionDataTask *) startRequest:(NSMutableURLRequest *) urlRequest
              request:(XBaseHttpRequest *) httpRequest
       uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
     downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
     completionHandle:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error)) completionHandle{
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:urlRequest
                                                               uploadProgress:uploadProgress
                                                             downloadProgress:downloadProgress
                                                            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                                if(error != NULL){
                                                                    //请求错误，非业务错误 可能客户端网络不好、服务端宕机等引发
                                                                    if([error code] == NSURLErrorTimedOut){
                                                                        id<XHttpRequestDelegate> newRequest = [httpRequest retry];
                                                                        if(!newRequest){
                                                                            [weakSelf processReuqestResultCallBack:httpRequest
                                                                                                    responseObject:responseObject
                                                                                                             error:error];
                                                                        }else{
                                                                            NSURLSessionDataTask *newTaskData = [weakSelf startRequest:urlRequest
                                                                                                                           request:httpRequest uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandle:completionHandle];
                                                                            [weakSelf processRequestRetryCallBack:httpRequest
                                                                                                       newRequest:newRequest];
                                                                            [weakSelf processRequestLoadingCallBack:newRequest
                                                                                                           progress:0
                                                                                                      totalProgress:100];
                                                                            
                                                                            if([newRequest isKindOfClass:[XBaseHttpRequest class]]){
                                                                                XBaseHttpRequest *newHttpRequest = (XBaseHttpRequest *)newRequest;
                                                                                [newHttpRequest setRequestObj:newTaskData];
                                                                                [newTaskData resume];
                                                                            }
                                                                        }
                                                                    }else{
                                                                        
                                                                        [weakSelf processReuqestResultCallBack:httpRequest
                                                                                                responseObject:responseObject
                                                                                                         error:error];
                                                                    }
                                                                }else{
                                                                    //业务请求结果，可能成功，可能失败
                                                                    [weakSelf processReuqestResultCallBack:httpRequest
                                                                                            responseObject:responseObject
                                                                                                     error:error];
                                                                }
                                                            }];
    return dataTask;
}


- (id<XHttpRequestDelegate>) requestWithMethod:(NSString *) method
                              requestUrlString:(NSString *) requestUrlString
                                  httpDelegate:(id<XHttpResponseDelegate>) delegate
                                 requestParams:(NSDictionary *) requestParams
                           requestHeaderParams:(NSDictionary *) requestHeaderParams
                                 responseblock:(XResponseBlock) responseblock{
    
    NSMutableURLRequest *request = [self createRequestURLWithMethod:method
                                                          urlString:requestUrlString
                                                      requestParams:requestParams
                                                requestHeaderParams:requestHeaderParams];
    
    if(!request){
        if(responseblock != NULL){
            responseblock(nil,nil,nil);
        }
        return NULL;
    }
    
    __block XBaseHttpRequest *httpRequest = [[XBaseHttpRequest alloc] init];
    [httpRequest addDelegate:delegate];
    [httpRequest addResponseReturnBlock:responseblock];
    [httpRequest willStartRequest:httpRequest];
    [httpRequest execWithRequest:httpRequest
                        progress:0 totalProgress:100];
    
    BOOL bNeedRequest = [self processRequestWithMethod:method
                                            requestUrl:requestUrlString
                                         requestParams:requestParams
                                               request:httpRequest];
    if(!bNeedRequest){
        return httpRequest;
    }
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [self startRequest:request
                                                request:httpRequest
                                         uploadProgress:NULL
                                       downloadProgress:^(NSProgress *downloadProgress) {
                                           [weakSelf processRequestLoadingCallBack:httpRequest
                                                                          progress:[downloadProgress fractionCompleted] * 100
                                                                     totalProgress:100];
                                       } completionHandle:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error)   {
                                       }];
    
    [httpRequest setRequestObj:dataTask];
    [dataTask resume];
    return httpRequest;
}


- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                       requestParams:(NSDictionary *) requestParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock{
    return [self getRequestWithUrlString:requestUrlString
                           requestParams:requestParams
                     requestHeaderParams:NULL
                            httpDelegate:delegate
                           responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                       requestParams:(NSDictionary *) requestParams
                                 requestHeaderParams:(NSDictionary *) requestHeaderParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock{

    
    return [self requestWithMethod:@"GET"
                  requestUrlString:requestUrlString
                      httpDelegate:delegate
                     requestParams:requestParams
               requestHeaderParams:requestHeaderParams
                     responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) postRequestWithUrlString:(NSString *) postUrlString
                                           postParams:(NSDictionary *) postParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock{
    return [self postRequestWithUrlString:postUrlString
                               postParams:postParams
                         postHeaderParams:NULL
                             httpDelegate:delegate
                            responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) postRequestWithUrlString:(NSString *) postUrlString
                                           postParams:(NSDictionary *) postParams
                                     postHeaderParams:(NSDictionary *) postHeaderParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock{
    return [self requestWithMethod:@"POST"
                  requestUrlString:postUrlString
                      httpDelegate:delegate
                     requestParams:postParams
               requestHeaderParams:postHeaderParams
                     responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) deleteRequestWithUrlString:(NSString *) deleteUrlString
                                           deleteParams:(NSDictionary *) deleteParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock{
    return [self deleteRequestWithUrlString:deleteUrlString
                               deleteParams:deleteParams
                        deleteRequestHeader:NULL
                               httpDelegate:delegate
                              responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) deleteRequestWithUrlString:(NSString *) deleteUrlString
                                           deleteParams:(NSDictionary *) deleteParams
                                    deleteRequestHeader:(NSDictionary *) deleteRequestHeader
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock{
    
    return [self requestWithMethod:@"DELETE"
                  requestUrlString:deleteUrlString
                      httpDelegate:delegate
                     requestParams:deleteParams
               requestHeaderParams:deleteRequestHeader
                     responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) headRequestWithUrlString:(NSString *) headUrlString
                                           headParams:(NSDictionary *) headParams
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock{
    return [self headRequestWithUrlString:headUrlString
                               headParams:headParams
                        headRequestHeader:NULL
                             httpDelegate:delegate
                            responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) headRequestWithUrlString:(NSString *) headUrlString
                                           headParams:(NSDictionary *) headParams
                                    headRequestHeader:(NSDictionary *) headRequestHeader
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock{
    return [self requestWithMethod:@"HEAD"
                  requestUrlString:headUrlString
                      httpDelegate:delegate
                     requestParams:headParams
               requestHeaderParams:headRequestHeader
                     responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) putRequestWithUrlString:(NSString *) putUrlString
                                           putParams:(NSDictionary *) putParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock{
    return [self putRequestWithUrlString:putUrlString
                               putParams:putParams
                        putRequestHeader:NULL
                            httpDelegate:delegate
                           responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) putRequestWithUrlString:(NSString *) putUrlString
                                           putParams:(NSDictionary *) putParams
                                    putRequestHeader:(NSDictionary *) putRequestHeader
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock{
    return [self requestWithMethod:@"PUT"
                  requestUrlString:putUrlString
                      httpDelegate:delegate
                     requestParams:putParams
               requestHeaderParams:putRequestHeader
                     responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) patchRequestWithUrlString:(NSString *) patchUrlString
                                           patchParams:(NSDictionary *) patchParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock{
    return [self patchRequestWithUrlString:patchUrlString
                               patchParams:patchParams
                        patchRequestHeader:NULL
                              httpDelegate:delegate
                             responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) patchRequestWithUrlString:(NSString *) patchUrlString
                                           patchParams:(NSDictionary *) patchParams
                                    patchRequestHeader:(NSDictionary *) patchRequestHeader
                                          httpDelegate:(id<XHttpResponseDelegate>) delegate
                                         responseblock:(XResponseBlock) responseblock{
    return [self requestWithMethod:@"PATCH"
                  requestUrlString:patchUrlString
                      httpDelegate:delegate
                     requestParams:patchParams
               requestHeaderParams:patchRequestHeader
                     responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) uploadRequestWithUrlString:(NSString *) uploadUrlString
                                       uploadParameters:(NSDictionary *) uploadParameters
                                         uploadFilePath:(NSString *) filePath
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock{
    
    return [self uploadRequestWithUrlString:uploadUrlString
                           uploadParameters:uploadParameters
                        uploadRequestHeader:NULL
                             uploadFilePath:filePath
                               httpDelegate:delegate
                              responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) uploadRequestWithUrlString:(NSString *) uploadUrlString
                                       uploadParameters:(NSDictionary *) uploadParameters
                                    uploadRequestHeader:(NSDictionary *) uploadRequestHeader
                                         uploadFilePath:(NSString *) filePath
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                                               URLString:uploadUrlString
                                                                                              parameters:uploadParameters
                                                                               constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                                                                                  [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath]
                                                                                                                             name:@"file"
                                                                                                                         fileName:[filePath lastPathComponent]
                                   
                                                                                                                         mimeType:@"application/octet-stream"
                                                                                                                            error:nil];
                                                                                              } error:&serializationError];
    if (serializationError) {
        if(responseblock != NULL){
            responseblock(nil,nil,nil);
        }
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self.sessionManager uploadTaskWithStreamedRequest:request
                                                                                   progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }
                                                                          completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            
        } else {
            
        }
    }];
    
    XBaseUploadHttpRequest *uploadHttpRequest = [[XBaseUploadHttpRequest alloc] init];
    [uploadHttpRequest setRequestObj:task];
    [uploadHttpRequest addDelegate:delegate];
    
    [uploadHttpRequest willStartRequest:uploadHttpRequest];
    [uploadHttpRequest execWithRequest:uploadHttpRequest progress:0 totalProgress:100];
    
    [task resume];
    return uploadHttpRequest;
}

- (id<XHttpRequestDelegate>) downloadRequestWithUrlString:(NSString *) downloadUrlString
                                       downloadParameters:(NSDictionary *) downloadParameters
                                             saveFilePath:(NSString *) saveFilePath
                                             httpDelegate:(id<XHttpResponseDelegate>) delegate
                                            responseblock:(XResponseBlock) responseblock{
    return [self downloadRequestWithUrlString:downloadUrlString
                           downloadParameters:downloadParameters
                        downloadRequestHeader:NULL
                                 saveFilePath:saveFilePath
                                 httpDelegate:delegate
                                responseblock:responseblock];
}

- (id<XHttpRequestDelegate>) downloadRequestWithUrlString:(NSString *) downloadUrlString
                                       downloadParameters:(NSDictionary *) downloadParameters
                                    downloadRequestHeader:(NSDictionary *) downloadRequestHeader
                                             saveFilePath:(NSString *) saveFilePath
                                             httpDelegate:(id<XHttpResponseDelegate>) delegate
                                            responseblock:(XResponseBlock) responseblock{
    NSURLRequest *downRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:downloadUrlString]];
    __block NSURLSessionDownloadTask *downloadTask = NULL;
    downloadTask = [self.sessionManager downloadTaskWithRequest:downRequest
                                                       progress:^(NSProgress * _Nonnull downloadProgress) {
                                            
                                        }           destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                            return [NSURL URLWithString:saveFilePath];
                                        }
                                              completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                            
                                        }];
    
    XBaseDownloadHttpRequest *downLoadHttpRequest = [[XBaseDownloadHttpRequest alloc] init];
    [downLoadHttpRequest setRequestObj:downloadTask];
    [downLoadHttpRequest addDelegate:delegate];
    [downLoadHttpRequest willStartRequest:downLoadHttpRequest];
    [downLoadHttpRequest execWithRequest:downLoadHttpRequest progress:0 totalProgress:100];
    
    [downloadTask resume];
    return downLoadHttpRequest;
}

@end
