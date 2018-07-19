//
//  XMutableArrayTypeValidator.m
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XMutableArrayTypeValidator.h"

@implementation XMutableArrayTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSMutableArray *list = [NSMutableArray array];
        if(value)
        {
            if([value isKindOfClass:[NSArray class]])
                list = [NSMutableArray arrayWithArray:value];
            else if([value isKindOfClass:[NSMutableArray class]]){
                list = [NSMutableArray arrayWithArray:value];
            }
        }
        return list;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
