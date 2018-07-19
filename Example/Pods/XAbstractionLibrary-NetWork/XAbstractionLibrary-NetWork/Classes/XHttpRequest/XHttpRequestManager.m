//
//  XHttpRequestManager.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/12.
//

#import "AFNetworking.h"
#import "XHttpRequest.h"
#import "XUploadHttpRequest.h"
#import "XHttpRequestManager.h"
#import "XDownloadHttpRequest.h"

@interface XHttpRequestManager()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@end

@implementation XHttpRequestManager

- (instancetype) init{
    if(self == [super init]){
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
        [urlRequest addValue:value forHTTPHeaderField:key];
    }
    return urlRequest;
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
    
    XHttpRequest *httpRequest = NULL;
    __block NSURLSessionDataTask *dataTask = nil;
    __weak typeof(self) weakSelf = self;
    dataTask = [self.sessionManager dataTaskWithRequest:request
                                         uploadProgress:NULL
                                       downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                                           [httpRequest execWithRequest:httpRequest progress:[downloadProgress fractionCompleted] * 100 totalProgress:100];
                                       }
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          if(error != NULL){
                                              //请求错误，非业务错误 可能客户端网络不好、服务端宕机等引发
                                              if([error code] == NSURLErrorTimedOut){
                                                  id<XHttpRequestDelegate> newRequest = [httpRequest retry];
                                                  if(!newRequest){
                                                      [httpRequest completeDidRequest:httpRequest responseDic:responseObject error:error];
                                                      if(responseblock){
                                                          responseblock(httpRequest,responseObject,error);
                                                      }
                                                  }else{
                                                      
                                                      [httpRequest willRetryRequest:httpRequest newRequest:newRequest];
                                                      
                                                      [dataTask resume];
                                                  }
                                              }else{
                                                  [httpRequest completeDidRequest:httpRequest
                                                                      responseDic:responseObject
                                                                            error:error];
                                                  if(responseblock != NULL){
                                                      responseblock(httpRequest,responseObject,error);
                                                  }
                                              }
                                          }else{
                                              //业务请求结果，可能成功，可能失败
                                              [httpRequest completeDidRequest:httpRequest
                                                                  responseDic:responseObject
                                                                        error:error];
                                              if(responseblock != NULL){
                                                  responseblock(httpRequest,responseObject,error);
                                              }
                                          }
                                      }];
    httpRequest = [[XHttpRequest alloc] initWithRequestTask:dataTask];
    [httpRequest addDelegate:delegate];
    
    [httpRequest willStartRequest:httpRequest];
    [httpRequest execWithRequest:httpRequest
                        progress:0 totalProgress:100];
    
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
    
    XUploadHttpRequest *uploadHttpRequest = [[XUploadHttpRequest alloc] initWithRequestTask:task];
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
    
    XDownloadHttpRequest *downLoadHttpRequest = [[XDownloadHttpRequest alloc] initWithRequestTask:downloadTask];
    [downLoadHttpRequest addDelegate:delegate];
    [downLoadHttpRequest willStartRequest:downLoadHttpRequest];
    [downLoadHttpRequest execWithRequest:downLoadHttpRequest progress:0 totalProgress:100];
    
    [downloadTask resume];
    return downLoadHttpRequest;
}

@end
