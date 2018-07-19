//
//  XConditionLock.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XConditionLock.h"

@interface XConditionLock ()
{
@private
    NSConditionLock *conditionLock_;
}
@end

@implementation XConditionLock

- (instancetype) init
{
    if(self = [super init])
    {
        conditionLock_ = [[NSConditionLock alloc] initWithCondition:XConditioData_NO];
    }
    return self;
}

- (XConditioData) condition
{
    return [conditionLock_ condition];
}

- (void) lock
{
    [conditionLock_ lock];
}

- (void) unlock
{
    [conditionLock_ unlock];
}

- (BOOL) readDataWithLockStateLock:(lockStateBlock)lockStateBlock WithLockBlock:(lockBlock) lockblock
{
    BOOL bLock = NO;
    NSDate *limitDate = [NSDate distantFuture];
    bLock = [self readDataWithLimitDate:limitDate WithLockStateLock:lockStateBlock lockblock:lockblock];
    return bLock;
}

- (BOOL) readDataWithLimitDate:(NSDate *)limitDate WithLockStateLock:(lockStateBlock)lockStateBlock lockblock:(lockBlock)lockblock
{
    BOOL bLock = NO;
    bLock = [conditionLock_ lockWhenCondition:XConditioData_HasData beforeDate:limitDate];
    if(bLock)
    {
        lockblock();
        NSUInteger number = lockStateBlock();
        [conditionLock_ unlockWithCondition:number > 0 ? XConditioData_HasData : XConditioData_NO];
    }
    return bLock;
}

- (void) writeDataWithLockBlock:(lockBlock) lockblock
{
    [conditionLock_ lock];
    lockblock();
    [conditionLock_ unlockWithCondition:XConditioData_HasData];
}

@end
