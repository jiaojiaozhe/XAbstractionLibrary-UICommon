//
//  AIBaseRequest.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseRequest.h"

@implementation AIBaseRequest
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *propertys = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    [propertys removeObjectForKey:@"header"];
    [propertys removeObjectForKey:@"command"];
    return propertys;
}
@end
