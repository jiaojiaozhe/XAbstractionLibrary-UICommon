//
//  DemoView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/6.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "DemoView.h"
#import "AIHttpRequestManager.h"

@implementation DemoView

- (UIView *) getContentView{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = RGB_COLOR(0, 255, 0);
    return contentView;
}

- (void) initView{
    
}

- (void)loadPage{
    NSMutableDictionary *cityParamsDic = [NSMutableDictionary dictionary];
    DICT_PUT(cityParamsDic, @"cityId", @"1");
    
    NSMutableDictionary *dataParamsDic = [NSMutableDictionary dictionary];
    DICT_PUT(dataParamsDic, @"data", cityParamsDic);
    DICT_PUT(dataParamsDic, @"version", @"1.0.0");
    
    NSMutableDictionary *requestHeaderParams = [NSMutableDictionary dictionary];
    DICT_PUT(requestHeaderParams, @"hKey", @"hValue");
    
    
    [self postRequestWithCommand:@"opertationsActivity/getDynamicImageList"
                      postParams:dataParamsDic
                postHeaderParams:requestHeaderParams
                    httpDelegate:self
                     resultClass:NULL
                     resultBlock:^(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
                         if([NSThread isMainThread]){
                             XLOG(@"main");
                         }else{
                             XLOG(@"not main");
                         }
                     } existsDataBlock:^BOOL(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
                         //需要业务工程师根据具体业务做处理
                         if(result){
                             return YES;
                         }else{
                             return NO;
                         }
                     }];
    
//    [[AIHttpRequestManager shareHttpRequestManager] postRequestWithCommand:@"opertationsActivity/getDynamicImageList"
//                                                                postParams:dataParamsDic
//                                                          postHeaderParams:requestHeaderParams
//                                                              httpDelegate:self
//                                                               resultClass:NULL
//                                                               resultBlock:^(id<XHttpRequestDelegate> request, AIBaseResult *result, id resultDic) {
//                                                                   if([NSThread isMainThread]){
//                                                                       XLOG(@"main");
//                                                                   }else{
//                                                                       XLOG(@"not main");
//                                                                   }
//                                                               }];

}

@end
