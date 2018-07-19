//
//  XDoubleTypeValidator.h
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "NSString+XCommon.h"
#import "XDoubleTypeValidator.h"

@implementation XDoubleTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = [NSNumber numberWithDouble:XDoubleDefaultVaue];
        if(value){
            if([value isKindOfClass:[NSNumber class]])
                number = value;
            else if([value isKindOfClass:[NSString class]]){
                NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                if([NSString isPureInt:lower])
                    number = [NSNumber numberWithDouble:[lower doubleValue]];
                else if([NSString isPureFloat:lower])
                    number = [NSNumber numberWithDouble:[lower doubleValue]];
                else if([NSString isPureDouble:lower])
                    number = [NSNumber numberWithDouble:[lower doubleValue]];
            }
        }
        return number;
    };
    
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
