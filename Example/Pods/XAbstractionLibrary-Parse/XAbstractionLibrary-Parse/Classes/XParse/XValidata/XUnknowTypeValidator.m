//
//  XUnknowTypeValidator.m
//
//  Created by lanbiao on 18/07/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XUnknowTypeValidator.h"

@implementation XUnknowTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        return XUnknowDefaultValue;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}

@end
