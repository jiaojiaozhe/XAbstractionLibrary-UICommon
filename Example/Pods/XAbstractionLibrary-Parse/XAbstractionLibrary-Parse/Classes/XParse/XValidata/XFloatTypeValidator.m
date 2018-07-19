//
//  XFloatTypeValidator.h
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "NSString+XCommon.h"
#import "XFloatTypeValidator.h"

@implementation XFloatTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = [NSNumber numberWithFloat:XFloatDefaultValue];
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                number = value;
            else if([value isKindOfClass:[NSString class]])
            {
                NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                if([NSString isPureInt:lower])
                    number = [NSNumber numberWithFloat:[lower floatValue]];
                else if([NSString isPureFloat:lower])
                    number = [NSNumber numberWithFloat:[lower floatValue]];
                else if([NSString isPureDouble:lower])
                    number = [NSNumber numberWithFloat:[lower floatValue]];
            }
        }
        return number;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
