//
//  XUnsignedCharTypeValidator.m
//
//  Created by lanbiao on 18/07/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XUnsignedCharTypeValidator.h"

@implementation XUnsignedCharTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = [NSNumber numberWithUnsignedChar:0];
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                number = [NSNumber numberWithUnsignedChar:[value unsignedCharValue]];
            else if([value isKindOfClass:[NSString class]]){
                if([value length] > 0)
                {
                    const char *ch = [[value objectAtIndex:0] UTF8String];
                    number = [NSNumber numberWithUnsignedChar:*ch];
                }
            }
        }
        
        return number;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
