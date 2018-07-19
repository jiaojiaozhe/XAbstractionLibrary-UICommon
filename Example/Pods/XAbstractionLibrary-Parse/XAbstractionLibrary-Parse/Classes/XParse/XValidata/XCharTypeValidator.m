//
//  XCharTypeValidator.m
//
//  Created by lanbiao on 18/7/22.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XCharTypeValidator.h"

@implementation XCharTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = [NSNumber numberWithChar:0];
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                number = [NSNumber numberWithChar:[value charValue]];
            else if([value isKindOfClass:[NSString class]])
            {
                if([value length] > 0)
                {
                    const char *ch = [[value objectAtIndex:0] UTF8String];
                    number = [NSNumber numberWithChar:*ch];
                }
            }
        }
        return number;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
