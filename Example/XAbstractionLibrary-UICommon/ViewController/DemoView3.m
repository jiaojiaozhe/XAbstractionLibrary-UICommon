//
//  DemoView3.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/10.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "DemoView3.h"
#import "BaseLoadingView.h"
#import "BaseErrorView.h"
#import "BaseNotDataView.h"
#import "BaseNotNetView.h"
#import "CustomHeadView.h"
#import "CustomFootView.h"
#import "AIRefreshBaseResult.h"
#import "AIHttpRequestManager.h"

/**
 接口请求的业务回调
 
 @param request 当前请求对象
 @param result 请求结果的解析对象
 @param resultDic 请求结果的原始数据
 */
typedef void(^RefreshResultBlock)(id<XHttpRequestDelegate> request,AIRefreshBaseResult *result,id resultDic);

/**
 接口请求的数据有效性回调，业务实现
 
 @param request 当前请求对象
 @param result 请求结果的解析对象
 @param resultDic 请求结果的原始数据
 @return YES数据有效 否则无效
 */
typedef BOOL(^RefreshExistsDataBlock)(id<XHttpRequestDelegate> request,AIRefreshBaseResult *result,id resultDic);

@interface DemoView3()
@property (nonatomic,strong) NSMutableArray *dataList;
@end

@implementation DemoView3

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

- (XListViewStyle) getListStyle{
    return XListViewStyleStandard;
}

- (XListHeadView *) loadHeadView{
    return [CustomHeadView createHeadView];
}

- (XListFootView *) loadFootView{
    return [CustomFootView createFootView];
}

- (void)initView{
    [super initView];
    [self setBAutoLoading:YES];
    [self setBPreLoadMore:YES];
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
                                                                      resultClass:resultClass
                                                                      resultBlock:^(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
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
    NSMutableDictionary *requestParams = nil;//[NSMutableDictionary dictionaryWithDictionary:[AIJSONAdapter JSONDictionaryFromModel:request error:nil]];
    NSMutableDictionary *requestHeadParams = nil;//[NSMutableDictionary dictionaryWithDictionary:[AIJSONAdapter JSONDictionaryFromModel:request.header error:nil]];
    return [self postRequestWithCommand:request.command
                             postParams:requestParams
                       postHeaderParams:requestHeadParams
                           httpDelegate:delegate
                            resultClass:resultClass
                            resultBlock:resultBlock
                        existsDataBlock:existsDataBlock];
}

- (NSDictionary *) refreshRequestParams{
    return nil;
}

- (NSDictionary *) loadMoreRequestParams{
    return nil;
}

- (void) loadPage{
    NSDictionary *requestParams = [self refreshRequestParams];
    if(requestParams){
        NSString *command = [requestParams objectForKey:@"command"];
        [self postRequestWithCommand:command
                          postParams:requestParams
                    postHeaderParams:nil
                        httpDelegate:self
                         resultClass:nil
                         resultBlock:^(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
                             if([NSThread isMainThread]){
                                 XLOG(@"main");
                             }else{
                                 XLOG(@"not main");
                             }
                         } existsDataBlock:^BOOL(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
                             if(result){
                                 return YES;
                             }else{
                                 return NO;
                             }
                         }];
    }
}

- (void)loadMore{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
