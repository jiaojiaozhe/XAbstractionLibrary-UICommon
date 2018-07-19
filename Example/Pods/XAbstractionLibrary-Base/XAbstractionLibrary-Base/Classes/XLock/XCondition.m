//
//  XCondition.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XCondition.h"

@interface XCondition ()
{
@private
    NSCondition *condition_;
}
@end

@implementation XCondition
- (instancetype) init
{
    if(self = [super init])
    {
        condition_ = [[NSCondition alloc] init];
    }
    return self;
}

- (void) lock:(lockBlock) lockblock
{
    [condition_ lock];
    if(lockblock)
        lockblock();
    [condition_ unlock];
}

- (BOOL) readDataWithLockStateLock:(lockStateBlock)lockStateBlock WithLockBlock:(lockBlock) lockblock
{
    BOOL bLock = NO;
    NSDate *limitDate = [NSDate distantFuture];
    bLock = [self readDataWithLimitDate:limitDate WithLockStateLock:lockStateBlock lockblock:lockblock];
    return bLock;
}

- (BOOL) readDataWithLimitDate:(NSDate *) limitDate WithLockStateLock:(lockStateBlock)lockStateBlock lockblock:(lockBlock) lockblock
{
    BOOL bLock = YES;
    [condition_ lock];
    NSUInteger number = lockStateBlock();
    if(number <= 0)
        bLock = [condition_ waitUntilDate:limitDate];
    
    if(bLock && lockblock)
        lockblock();
    [condition_ unlock];
    return bLock;
}

- (void) writeDataWithLockBlock:(lockBlock) lockblock
{
    [condition_ lock];
    if(lockblock)
        lockblock();
    [condition_ signal];
    [condition_ unlock];
}
@end
