//
//  XHttpRequest.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/12.
//

#import "XBaseHttpRequest.h"
#import "XHttpResponseDelegate.h"

@interface XBaseHttpRequest()
@property (nonatomic,strong) id requestObj;
@end

@implementation XBaseHttpRequest
@synthesize requestObj = _requestObj;

- (instancetype) init{
    if(self = [super init]){
        self.retryCount = 1;
    }
    return self;
}

- (void) setRequestObj:(id) request{
    _requestObj = request;
}

- (id) requestObj{
    return _requestObj;
}

/**
 *  取消请求
 */
- (void) cancel{
    if(self.requestObj){
        if([self.requestObj isKindOfClass:[NSURLSessionTask class]]){
            NSURLSessionTask *sessionTask = (NSURLSessionTask*)self.requestObj;
            if([sessionTask state] != NSURLSessionTaskStateCompleted &&
               [sessionTask state] != NSURLSessionTaskStateCanceling){
                [sessionTask cancel];
            }
        }
    }
    
    if(self.ownerDelegate &&
       [((id)self.ownerDelegate) respondsToSelector:@selector(cancelRequest:)]){
        [((id)self.ownerDelegate) cancelRequest:self];
    }
}

/**
 *  重试请求
 *
 *  @return nil 不能重试 否则返回一个新请求对象
 */
- (instancetype) retry{
    [self cancel];
    if([self retryCount] >= 3){
        return NULL;
    }
    
    self.retryCount += 1;
    XBaseHttpRequest *newHttpRequest = self;//[self copy];
    return newHttpRequest;
}

- (void) addDelegate:(id<XHttpResponseDelegate>) delegate{
    self.ownerDelegate = delegate;
}

- (void) removeDelegate:(id<XHttpResponseDelegate>) delegate{
    if(delegate == self.ownerDelegate){
        self.ownerDelegate = nil;
    }
}

- (void) addResponseReturnBlock:(XResponseBlock) responseBlock{
    self.responseBlock = responseBlock;
}

- (void) removeResponseReturnBlock:(XResponseBlock) responseBlock{
    if(self.responseBlock == responseBlock){
        self.responseBlock = nil;
    }
}

- (void) willStartRequest:(id<XHttpRequestDelegate>) request{
    if(self.ownerDelegate &&
       [((id)self.ownerDelegate) respondsToSelector:@selector(willStartRequest:)]){
        [((id)self.ownerDelegate) willStartRequest:request];
    }
}

- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest{
    if(self.ownerDelegate &&
       [((id)self.ownerDelegate) respondsToSelector:@selector(willRetryRequest:newRequest:)]){
        [((id)self.ownerDelegate) willRetryRequest:oldRequest newRequest:newRequest];
    }
}

- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress{
    if(self.ownerDelegate &&
       [((id)self.ownerDelegate) respondsToSelector:@selector(execWithRequest:progress:totalProgress:)]){
        [((id)self.ownerDelegate) execWithRequest:request progress:progress totalProgress:totalProgress];
    }
}

- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error{
    if(self.ownerDelegate &&
       [((id)self.ownerDelegate) respondsToSelector:@selector(completeDidRequest:responseDic:error:)]){
        [((id)self.ownerDelegate) completeDidRequest:request responseDic:responseDic error:error];
    }
}

#pragma mark --NSCopying
- (id) copyWithZone:(NSZone *)zone{
    XBaseHttpRequest *newHttpRequest = [[[self class] allocWithZone:zone] init];
    newHttpRequest.requestObj = [self.requestObj copy];
    newHttpRequest.retryCount = self.retryCount;
    newHttpRequest.ownerDelegate = self.ownerDelegate;
    newHttpRequest.command = self.command;
    newHttpRequest.responseBlock = self.responseBlock;
    return newHttpRequest;
}
@end
