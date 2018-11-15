//
//  AIBaseView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseView.h"
#import "AIBaseLoadingView.h"
#import "AIBaseErrorView.h"
#import "AIBaseNotNetView.h"
#import "AIBaseNotDataView.h"

@implementation AIBaseView

- (id<XIBaseLoadingViewDelegate>)loadLoadingView{
    id<XIBaseLoadingViewDelegate> loadingView = [AIBaseLoadingView createLoadingView];
    if(loadingView &&
       [loadingView respondsToSelector:@selector(initView)]){
        [loadingView initView];
    }
    return loadingView;
}

- (id<XIBaseNotNetViewDelegate>)loadNotNetView{
    id<XIBaseNotNetViewDelegate> notNetView = [AIBaseNotNetView createNotNetView];
    if(notNetView &&
       [notNetView respondsToSelector:@selector(initView)]){
        [notNetView initView];
    }
    return notNetView;
}

- (id<XIBaseErrorViewDelegate>)loadErrorView{
    id<XIBaseErrorViewDelegate> errorView = [AIBaseErrorView createErrorView];
    if(errorView &&
       [errorView respondsToSelector:@selector(initView)]){
        [errorView initView];
    }
    return errorView;
}

- (id<XIBaseNotDataViewDelegate>)loadNotDataView{
    id<XIBaseNotDataViewDelegate> notDataView = [AIBaseNotDataView createNotDataView];
    if(notDataView &&
       [notDataView respondsToSelector:@selector(initView)]){
        [notDataView initView];
    }
    return notDataView;
}

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *)command
                                         postParams:(NSDictionary *)postParams
                                   postHeaderParams:(NSDictionary *)postHeaderParams
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock{
    __weak typeof(self) weakSelf = self;
    return [[AIHttpRequestManager shareHttpRequestManager] postRequestWithCommand:command
                                                                       postParams:postParams
                                                                 postHeaderParams:postHeaderParams
                                                                     httpDelegate:self
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
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock{
    NSMutableDictionary *requestParams = [NSMutableDictionary dictionaryWithDictionary:[XJSONAdapter JSONDictionaryFromModel:request error:nil]];
    NSMutableDictionary *requestHeadParams = [NSMutableDictionary dictionaryWithDictionary:[XJSONAdapter JSONDictionaryFromModel:request.header error:nil]];
    return [self postRequestWithCommand:request.command
                             postParams:requestParams
                       postHeaderParams:requestHeadParams
                            resultClass:resultClass
                            resultBlock:resultBlock
                        existsDataBlock:existsDataBlock];
}

@end
