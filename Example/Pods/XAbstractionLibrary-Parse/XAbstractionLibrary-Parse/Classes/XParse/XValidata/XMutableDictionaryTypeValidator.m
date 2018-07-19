//
//  XMutableDictionaryTypeValidator.m
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2017年 lanbiao. All rights reserved.
//

#import "XMutableDictionaryTypeValidator.h"

@implementation XMutableDictionaryTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if(value)
        {
            if([value isKindOfClass:[NSDictionary class]])
                dic = [NSMutableDictionary dictionaryWithDictionary:value];
            else if([value isKindOfClass:[NSMutableDictionary class]])
                dic = [NSMutableDictionary dictionaryWithDictionary:value];
        }
        return dic;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
