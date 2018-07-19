//
//  XRecursiveLock.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/29.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XRecursiveLock.h"

@interface XRecursiveLock ()
{
@private
    NSRecursiveLock *lock_;
}
@end

@implementation XRecursiveLock
- (instancetype) init
{
    if(self = [super init])
    {
        lock_ = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (BOOL) tryLock:(lockBlock) lockblock
{
    BOOL bLock = NO;
    bLock = [lock_ tryLock];
    if(bLock)
        lockblock();
    return bLock;
}

- (BOOL) lockBeforeDate:(NSDate *)limit lockBlock:(lockBlock) lockblock
{
    BOOL bLock = NO;
    bLock = [lock_ lockBeforeDate:limit];
    if(bLock)
        lockblock();
    return bLock;
}

- (void) lock:(lockBlock) lockblock
{
    [lock_ lock];
    lockblock();
    [lock_ unlock];
}
@end
