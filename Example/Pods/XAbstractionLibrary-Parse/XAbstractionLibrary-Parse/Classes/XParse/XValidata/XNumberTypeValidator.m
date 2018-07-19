//
//  XNumberTypeValidator.m
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "NSString+XCommon.h"
#import "XNumberTypeValidator.h"

@implementation XNumberTypeValidator

+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = XNumberDefaultValue;
        if(value){
            if([value isKindOfClass:[NSNumber class]])
                number = value;
            else if([value isKindOfClass:[NSString class]]){
                NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                if([NSString isPureInt:lower])
                    number = [NSNumber numberWithInteger:[lower integerValue]];
                else if([NSString isPureFloat:lower])
                    number = [NSNumber numberWithFloat:[lower floatValue]];
                else if([NSString isPureDouble:lower])
                    number = [NSNumber numberWithDouble:[lower doubleValue]];
                else
                {
                    if([lower isEqualToString:@"f"] ||
                       [lower isEqualToString:@"false"] ||
                       [lower isEqualToString:@"no"] ||
                       [lower isEqualToString:@"n"]){
                        number = [NSNumber numberWithBool:NO];
                    }else{
                        number = [NSNumber numberWithBool:YES];
                    }
                }
            }
        }
        return number;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
