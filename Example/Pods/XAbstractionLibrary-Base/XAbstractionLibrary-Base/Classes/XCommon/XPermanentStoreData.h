//
//  XPermanentStoreData.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 18/7/20.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import <Foundation/Foundation.h>

/**
 *  持久存储数据
 */
@interface XPermanentStoreData : XData

/**
 *  持久化字符串
 *
 *  @param value        待持久的字符串
 *  @param cacheKey     待持久字符串的key
 *  @return   YES 持久成功  NO 持久失败
 */
+ (BOOL) saveStringToCache:(NSString *) value cacheKey:(NSString *) cacheKey;

/**
 *  在本地持久中查找cachekey下的字符串
 *
 *  @param cacheKey 待持久字符串的key
 *
 *  @return 获取到的cachekey下的字符串
 */
+ (NSString *) valueFromCache:(NSString *) cacheKey;


/**
 *  持久数据模型
 *
 *  @param modelValue   待持久的模型数据
 *  @param cacheKey     待持久模型的key
 *  @return   YES 持久成功  NO 持久失败
 */
+ (BOOL) saveModelToCache:(NSObject *) modelValue cacheKey:(NSObject *) cacheKey;

/**
 *  在本地持久中查找cachekey下的模型数据
 *
 *  @param cacheKey 持久模型的key
 *
 *  @return 获取到模型数据
 */
+ (NSObject *) modelFromCacheKey:(NSString *) cacheKey;

/**
 *  清除本地所有的持久
 *
 *  @return YES 成功 否则失败
 */
+ (BOOL) removeCache:(NSString *) cacheKey;

@end
