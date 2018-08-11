//
//  AIHttpsRequestManager.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIHttpsRequestManager.h"

@implementation AIHttpsRequestManager

#pragma mark --单例模式
+ (instancetype) shareHttpsRequestManager{
    static AIHttpsRequestManager *requestManager = nil;
#if !__has_feature(objc_arc)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [NSAllocateObject([self class], 0, nil) init];
    });
#else
    //    requestManager = [[[self class] alloc] init];
    requestManager = [[self class] alloc];
#endif
    return requestManager;
}

+ (id) allocWithZone:(struct _NSZone *)zone{
#if !__has_feature(objc_arc)
    return [[self shareHttpsRequestManager] retain];
#else
    static AIHttpsRequestManager *requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[super allocWithZone:zone] init];
    });
    return requestManager;
#endif
}

#if !__has_feature(objc_arc)
- (id) retain{
    return self;
}

- (NSUInteger) retainCount{
    return NSUIntegerMax;
}

- (id) autorelease{
    return self;
}

- (oneway void) release{
}
#endif

- (id) copyWithZone:(NSZone *)zone{
    return self;
}

- (instancetype) init{
    if(self = [super init]){
        self.httpHostAddress = @"http://121.43.147.67:8080/";
    }
    return self;
}

@end
