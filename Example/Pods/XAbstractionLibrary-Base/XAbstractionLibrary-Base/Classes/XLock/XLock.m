//
//  XLock.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XLock.h"

@interface XLock ()
{
@private
    NSLock  *lock_;
}
@end

@implementation XLock

- (instancetype) init
{
    if(self = [super init])
    {
        lock_ = [[NSLock alloc] init];
    }
    return self;
}

- (void) lock
{
    [lock_ lock];
}

- (void) unlock
{
    [lock_ unlock];
}

- (void) lock:(lockBlock) lockblock
{
    [lock_ lock];
    lockblock();
    [lock_ unlock];
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
@end
