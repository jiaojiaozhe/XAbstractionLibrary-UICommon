//
//  XCondition.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

typedef NSUInteger (^lockStateBlock)(void);
typedef void(^lockBlock)(void);

@interface XCondition : XData

/**
 *  锁定原子执行block代码块
 *
 *  @param lockblock 成功加锁后待执行的block
 */
- (void) lock:(lockBlock) lockblock;

/**
 *  在默认的5秒内，获得读取数据锁,成功就执行代码块，并且根据返回结果重置条件。否则直接返回
 *
 *  @param lockblock 获取到锁后，待执行的代码块
 *
 *  @return 成功 YES 失败 NO
 */
- (BOOL) readDataWithLockStateLock:(lockStateBlock)lockStateBlock WithLockBlock:(lockBlock) lockblock;

/**
 *  在指定的时间内，获得读取数据锁,成功就执行代码块，并且根据返回结果重置条件。否则直接返回
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
