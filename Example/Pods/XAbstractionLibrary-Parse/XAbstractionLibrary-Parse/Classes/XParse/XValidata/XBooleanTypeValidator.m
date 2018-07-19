//
//  XBooleanTypeValidator.m
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XBooleanTypeValidator.h"

@implementation XBooleanTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        BOOL bTransform = XBooleanDefaultValue;
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                bTransform = [value boolValue];
            else if([value isKindOfClass:[NSString class]])
            {
                NSString *lowerStr = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                
                if([NSString isPureInt:lowerStr] ||
                   [NSString isPureFloat:lowerStr] ||
                   [NSString isPureDouble:lowerStr]){
                    bTransform = YES;
                }else if([lowerStr isEqualToString:@"f"] ||
                         [lowerStr isEqualToString:@"false"] ||
                         [lowerStr isEqualToString:@"no"] ||
                         [lowerStr isEqualToString:@"n"]){
                    bTransform = NO;
                }else{
                    bTransform = YES;
                }
            }else{
                bTransform = YES;
            }
        }
        return @(bTransform);
    };
    
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
