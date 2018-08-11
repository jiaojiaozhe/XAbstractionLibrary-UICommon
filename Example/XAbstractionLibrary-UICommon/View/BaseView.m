//
//  BaseView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseView.h"
#import "AIJSONAdapter.h"
#import "BaseLoadingView.h"
#import "BaseErrorView.h"
#import "BaseNotNetView.h"
#import "BaseNotDataView.h"

@implementation BaseView

- (id<XIBaseLoadingViewDelegate>) loadLoadingView{
    id<XIBaseLoadingViewDelegate> baseLoadingView = [BaseLoadingView createLoadingView];
    if(baseLoadingView){
        if([baseLoadingView respondsToSelector:@selector(initView)]){
            [baseLoadingView initView];
        }
    }
    
    return baseLoadingView;
}

- (id<XIBaseErrorViewDelegate>) loadErrorView{
    id<XIBaseErrorViewDelegate> errorView = [BaseErrorView createErrorView];
    if(errorView){
        if([errorView respondsToSelector:@selector(initView)]){
            [errorView initView];
        }
        errorView.retryDelegate = self;
    }
    return errorView;
}

- (id<XIBaseNotNetViewDelegate>) loadNotNetView{
    id<XIBaseNotNetViewDelegate> notNetView = [BaseNotNetView createNotNetView];
    if(notNetView){
        if([notNetView respondsToSelector:@selector(initView)]){
            [notNetView initView];
        }
        notNetView.retryDelegate = self;
    }
    return notNetView;
}

- (id<XIBaseNotDataViewDelegate>) loadNotDataView{
    id<XIBaseNotDataViewDelegate> notDataView = [BaseNotDataView createNotDataView];
    if(notDataView){
        if([notDataView respondsToSelector:@selector(initView)]){
            [notDataView initView];
        }
        notDataView.retryDelegate = self;
    }
    return notDataView;
}

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *)command
                                         postParams:(NSDictionary *)postParams
                                   postHeaderParams:(NSDictionary *)postHeaderParams
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock{
    __weak typeof(self) weakSelf = self;
    return [[AIHttpRequestManager shareHttpRequestManager] postRequestWithCommand:command
                                                                       postParams:postParams
                                                                 postHeaderParams:postHeaderParams
                                                                     httpDelegate:delegate
                                                                      resultClass:resultClass resultBlock:^(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
                                                                          if([result isSuccess]){
                                                                              if(existsDataBlock){
                                                                                  BOOL bExistsData = existsDataBlock(request,result,resultDic);
                                                                                  if(bExistsData){
                                                                                      [weakSelf setBIgnoreShowError:YES];
                                                                                  }else{
                                                                                      [weakSelf setBNotData:YES];
                                                                                  }
                                                                              }
                                                                              if(resultBlock){
                                                                                  resultBlock(request,result,resultDic);
                                                                              }
                                                                          }else{
                                                                              if(resultBlock){
                                                                                  resultBlock(request,result,resultDic);
                                                                              }
                                                                          }
                                                                      }];
}

- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock{
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:[AIJSONAdapter JSONDictionaryFromModel:request error:nil]];
    NSMutableDictionary *requestHeadParams = [NSMutableDictionary dictionaryWithDictionary:[AIJSONAdapter JSONDictionaryFromModel:request.header error:nil]];
    return [self postRequestWithCommand:request.command
                             postParams:requestParams
                       postHeaderParams:requestHeadParams
                           httpDelegate:delegate
                            resultClass:resultClass
                            resultBlock:resultBlock
                        existsDataBlock:existsDataBlock];
}

@end
