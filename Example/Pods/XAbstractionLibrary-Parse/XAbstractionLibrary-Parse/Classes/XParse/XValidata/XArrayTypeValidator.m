//
//  XArrayTypeValidator.m
//
//  Created by lanbiao on 18/7/21.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XArrayTypeValidator.h"

@implementation XArrayTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSArray *list = [NSArray array];
        if(value)
        {
            if([value isKindOfClass:[NSArray class]])
                list = [NSArray arrayWithArray:value];
            else if([value isKindOfClass:[NSMutableArray class]]){
                list = [NSArray arrayWithArray:value];
            }
        }
        return list;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
