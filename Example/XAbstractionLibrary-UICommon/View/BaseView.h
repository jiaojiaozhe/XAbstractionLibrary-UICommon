//
//  BaseView.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "AIBaseRequest.h"
#import "AIHttpRequestManager.h"
#import "AIHttpsRequestManager.h"
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

@interface BaseView : XView

- (id<XHttpRequestDelegate>) postRequestWithRequest:(AIBaseRequest *) request
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock;

- (id<XHttpRequestDelegate>) postRequestWithCommand:(NSString *)command
                                         postParams:(NSDictionary *)postParams
                                   postHeaderParams:(NSDictionary *)postHeaderParams
                                       httpDelegate:(id<XHttpResponseDelegate>)delegate
                                        resultClass:(__unsafe_unretained Class)resultClass
                                        resultBlock:(ResultBlock)resultBlock
                                    existsDataBlock:(ExistsDataBlock)existsDataBlock;

@end
