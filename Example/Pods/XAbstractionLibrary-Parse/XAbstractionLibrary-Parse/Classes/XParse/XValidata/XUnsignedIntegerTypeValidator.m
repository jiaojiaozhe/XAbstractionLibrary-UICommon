//
//  XUnsignedIntegerTypeValidator.h
//
//  Created by lanbiao on 18/07/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "NSString+XCommon.h"
#import "XUnsignedIntegerTypeValidator.h"

@implementation XUnsignedIntegerTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = [NSNumber numberWithUnsignedInteger:XUnsignedIntergeDefaultValue];
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                number = value;
            else if([value isKindOfClass:[NSString class]])
            {
                NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                if([NSString isPureInt:lower])
                    number = [NSNumber numberWithUnsignedInteger:(NSUInteger)[lower longLongValue]];
                else if([NSString isPureFloat:lower])
                    number = [NSNumber numberWithUnsignedInteger:(NSUInteger)[lower longLongValue]];
                else if([NSString isPureDouble:lower])
                    number = [NSNumber numberWithUnsignedInteger:(NSUInteger)[lower longLongValue]];
            }
        }
        return number;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
