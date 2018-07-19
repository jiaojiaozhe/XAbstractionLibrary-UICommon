//
//  XDictionaryTypeValidator.m
//
//  Created by lanbiao on 19/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XDictionaryTypeValidator.h"

@implementation XDictionaryTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if(value)
        {
            if([value isKindOfClass:[NSDictionary class]])
                dic = value;
        }
        return dic;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
