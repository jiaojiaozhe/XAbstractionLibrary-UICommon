//
//  NSString+XCommon.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/10.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XNumber)

/**
 *  判断是否为整形
 *
 *  @param string 带判断的字符串
 *
 *  @return YES 是 NO 否
 */
+ (BOOL)isPureInt:(NSString*)string;


/**
 *  判断是为单精度的浮点型
 *
 *  @param string 待判断的字符串
 *
 *  @return YES 是  NO 否
 */
+ (BOOL)isPureFloat:(NSString*)string;


/**
 *  判断是否为双精度的浮点型
 *
 *  @param string 待判断的字符串
 *
 *  @return YES 是 NO 否
 */
+ (BOOL) isPureDouble:(NSString*) string;

/**
 *  判断是否为数字
 *
 *  @param string 待判断的字符串
 *
 *  @return YES 是 NO 否
 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;

@end
