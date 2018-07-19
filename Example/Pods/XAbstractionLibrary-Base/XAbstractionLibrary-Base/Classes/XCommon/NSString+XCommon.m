//
//  NSString+XCommon.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/10.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "NSString+XCommon.h"

@implementation NSString(XNumber)

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL) isPureDouble:(NSString*) string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0 && ![string isEqualToString:@"."])
        return NO;
    return YES;
}
@end
