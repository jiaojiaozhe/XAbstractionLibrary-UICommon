//
//  XHttpRequest.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/12.
//

#import "XHttpRequest.h"

@interface XHttpRequest()
@property (nonatomic,strong) id requestObj;
@end

@implementation XHttpRequest

- (instancetype) initWithRequestTask:(id) request{
    if(self == [super init]){
        self.requestObj = request;
    }
    return self;
}

/**
 *  取消请求
 */
- (void) cancel{
    
}

/**
 *  重试请求
 *
 *  @return nil 不能重试 否则返回一个新请求对象
 */
- (instancetype) retry{
    return NULL;
}

/**
 *  删除依赖于该接口的代理
 */
- (void) removeDelegate:(id<XHttpResponseDelegate>) delegate{
    
}

/**
 *  添加依赖于该接口的代理
 */
- (void) addDelegate:(id<XHttpResponseDelegate>) delegate{
    
}

- (void) willStartRequest:(id<XHttpRequestDelegate>) request{
    
}

- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest{
    
}

- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress{
    
}

- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error{
    
}
@end
