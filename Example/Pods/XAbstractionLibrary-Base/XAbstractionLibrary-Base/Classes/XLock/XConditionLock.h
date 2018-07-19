//
//  XConditionLock.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

typedef NS_ENUM(NSUInteger, XConditioData) {
    XConditioData_NO,
    XConditioData_HasData
};

typedef NSUInteger (^lockStateBlock)(void);
typedef void(^lockBlock)(void);
/**
 ConditionLock所对象类，用于代替NSConditionLock
 */
@interface XConditionLock : XData

/**
 *  获取锁条件
 *
 *  @return 返回条件
 */
- (XConditioData) condition;


/**
 *  加锁
 */
- (void) lock;


/**
 *  解锁
 */
- (void) unlock;

/**
 *  在默认的5秒内，获得读取数据锁,成功就执行代码块，否则直接返回
 *
 *  @param lockblock 获取到锁后，待执行的代码块
 *
 *  @return 成功 YES 失败 NO
 */
- (BOOL) readDataWithLockStateLock:(lockStateBlock)lockStateBlock WithLockBlock:(lockBlock) lockblock;

/**
 *  在指定的时间内，获得读取数据锁,成功就执行代码块,否则直接返回
 *
 *  @param lockblock 获取到锁后，待执行的代码块
 *
 *  @return 成功 YES 失败 NO
 */
- (BOOL) readDataWithLimitDate:(NSDate *) limitDate WithLockStateLock:(lockStateBlock)lockStateBlock lockblock:(lockBlock) lockblock;

/**
 *  获得所对象，并将改变condition的状态为有数据
 *
 *  @param lockblock 获得锁对象资源后，待执行的代码块
 */
- (void) writeDataWithLockBlock:(lockBlock) lockblock;
@end
