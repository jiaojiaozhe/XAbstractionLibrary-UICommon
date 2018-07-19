//
//  XRecursiveLock.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/29.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

typedef void(^lockBlock)(void);

/**
 *  RecursiveLock基础锁对象，替换系统NSRecursiveLock
 */
@interface XRecursiveLock : XData
/**
 *  锁定原子执行block代码块
 *
 *  @param lockblock 成功加锁后待执行的block
 */
- (void) lock:(lockBlock) lockblock;

/**
 *  尝试锁定，不至于阻塞线程
 *
 *  @param lockblock 成功加锁后待执行的block
 *
 *  @return YES 加锁成功 NO 加锁失败
 */
- (BOOL) tryLock:(lockBlock) lockblock;

/**
 *
 *  @param limit     阻塞线程，直到指定日期时间自动解锁
 *  @param lockblock 成功加锁后待执行的block
 *
 *  @return YES 加锁成功 NO 加锁失败
 */
- (BOOL) lockBeforeDate:(NSDate *)limit lockBlock:(lockBlock) lockblock;
@end
