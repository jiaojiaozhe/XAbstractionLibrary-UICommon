//
//  XDataTypeValidator.m
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XDataTypeValidator.h"

@implementation XDataTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSData *data = nil;
        if(value){
            if([value isKindOfClass:[NSNumber class]]){
                NSString *objStr = [value stringValue];
                data = [objStr dataUsingEncoding:NSUTF8StringEncoding];
            }else if([value isKindOfClass:[NSString class]]){
                data = [value dataUsingEncoding:NSUTF8StringEncoding];
            }
        }
        return data;
    };
    
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
