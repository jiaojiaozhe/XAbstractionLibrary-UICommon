//
//  ResolveResult.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIJSONAdapter.h"
#import "AIResolveResult.h"

@implementation AIResolveResult

+ (AIBaseResult *) resolveWithClass:(Class) resultClass
                          resultObj:(id) resultObj
                              error:(NSError *) error{
    AIBaseResult *result = NULL;
    if(error){
        //请求发生错误
        if(error.code == NSURLErrorTimedOut){
            result = [AIBaseResult createTimerout];
        }else{
            result = [AIBaseResult createOtherError];
        }
    }else{
        if(resultObj){
            if([resultObj isKindOfClass:[NSDictionary class]]){
                if(resultClass){
                    result = [AIJSONAdapter modelOfClass:resultClass
                                      fromJSONDictionary:resultObj
                                                   error:nil];
                }else{
                    //没有解析结果的class
                    result = [AIJSONAdapter modelOfClass:[AIBaseResult class]
                                      fromJSONDictionary:resultObj
                                                   error:nil];
                }
            }else{
                //resultObj是其它类型
                result = [AIBaseResult createOtherError];
            }
        }else{
            //没有返回数据
            result = [AIBaseResult createOtherError];
        }
    }
    
    return result;
}
@end
