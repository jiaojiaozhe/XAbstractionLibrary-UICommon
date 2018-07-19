//
//  XDeviceMacros.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/13.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XDeviceMacros_h
#define XAbstractionLibrary_XDeviceMacros_h

/**
 *  判断是否为iPhone
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/**
 *  判断是否为iPad
 */
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  判断是否为ipod
 */
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/**
 *  判断是否retina屏
 */
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

/**
 *  获得屏幕长的那边
 */
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

/**
 *  获得屏幕短的那边
 */
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


/**
 *  iPhone4(包含)以下机型
 */
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

/**
 *  iPhone5、iPhone5S、iPhoneSE、iPhone5C机型
 */
#define IS_IPHONE_5SEC (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

/**
 *  iPhone6、iPhone6s、iPhone7、iPhone8机型
 */
#define IS_IPHONE_6S78 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

/**
 *  iPhone6P、iPhone6SP、iPhone7P、iPhone8P机型
 */
#define IS_IPHONE_6S78P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/**
 *  iPhoneX
 */
#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

/**
 *  比iPhoneX更大的设备，未来可能存在
 */
#define IS_IPHONE_X_UP （IS_IPHONE && SCREEN_MAX_LENGTH > 812.0）

#endif
