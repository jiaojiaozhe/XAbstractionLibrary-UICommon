//
//  XDateTypeValidator.m
//
//  Created by lanbiao on 18/7/31.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "NSString+XCommon.h"
#import "XDateTypeValidator.h"


@implementation XDateTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSDate *date = nil;
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
            else if([value isKindOfClass:[NSString class]]){
                if([NSString isPureNumandCharacters:value]){
                    date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                }
                else{
                    NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
                    [dataFormatter setDateFormat:@"yy-MM-dd HH:mm:ss zzzz"];
                    date = [dataFormatter dateFromString:lower];
                    
                    if(!date){
                        [dataFormatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
                        date = [dataFormatter dateFromString:lower];
                    }
                    
                    if(!date){
                        [dataFormatter setDateFormat:@"yy-MM-dd HH:mm"];
                        date = [dataFormatter dateFromString:lower];
                    }
                    
                    if(!date){
                        [dataFormatter setDateFormat:@"yy-MM-dd HH"];
                        date = [dataFormatter dateFromString:lower];
                    }
                    
                    if(!date){
                        [dataFormatter setDateFormat:@"yy-MM-dd"];
                        date = [dataFormatter dateFromString:lower];
                    }
                }
            }
            else if([value isKindOfClass:[NSDate class]])
                date = value;
        }
        return date;
    };
    
    MTLValueTransformerBlock reverseBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *date = nil;
        if(value){
            if([value isKindOfClass:[NSNumber class]])
                date = value;
            else if([value isKindOfClass:[NSString class]]){
                NSDate *dateObj = nil;
                if([NSString isPureNumandCharacters:value]){
                    dateObj = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                }
                else{
                    NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
                    [dataFormatter setDateFormat:@"yy-MM-dd HH:mm:ss zzzz"];
                    dateObj = [dataFormatter dateFromString:lower];
                    
                    if(!dateObj){
                        [dataFormatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
                        dateObj = [dataFormatter dateFromString:lower];
                    }
                    
                    if(!dateObj){
                        [dataFormatter setDateFormat:@"yy-MM-dd HH:mm"];
                        dateObj = [dataFormatter dateFromString:lower];
                    }
                    
                    if(!dateObj){
                        [dataFormatter setDateFormat:@"yy-MM-dd HH"];
                        dateObj = [dataFormatter dateFromString:lower];
                    }
                    
                    if(!dateObj){
                        [dataFormatter setDateFormat:@"yy-MM-dd"];
                        dateObj = [dataFormatter dateFromString:lower];
                    }
                }
                
                if(dateObj != NULL)
                    date = [NSNumber numberWithDouble:[dateObj timeIntervalSince1970]];
            }
            else if([value isKindOfClass:[NSDate class]])
                date = [NSNumber numberWithDouble:[value timeIntervalSince1970]];;
        }
        return date;
    };
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:reverseBlock];
}
@end
