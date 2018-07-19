//
//  XNonRetainObject.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/21.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XNonRetainObject.h"

// 不使用retain
static const void* XRetainNo(CFAllocatorRef allocator, const void *value) { return value; }
static void XReleaseNo(CFAllocatorRef allocator, const void *value) { }


NSMutableArray* XCreateNonRetainingArray(void)
{
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = XRetainNo;
    callbacks.release = XReleaseNo;
    return (NSMutableArray*)CFBridgingRelease(CFArrayCreateMutable(nil, 0, &callbacks));
}


NSMutableDictionary *XCreateNonRetainingDictionary(void)
{
    CFDictionaryKeyCallBacks keyCallbacks = kCFTypeDictionaryKeyCallBacks;
    CFDictionaryValueCallBacks callbacks = kCFTypeDictionaryValueCallBacks;
    callbacks.retain = XRetainNo;
    callbacks.release = XReleaseNo;
    return CFBridgingRelease(CFDictionaryCreateMutable(nil, 0, &keyCallbacks, &callbacks));
}
