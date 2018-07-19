//
//  NSMutableDictionary+Crash.m
//  XAbstractionLibrary-Base
//
//  Created by lanbiao on 2018/7/16.
//

#import <objc/runtime.h>
#import "XGlobalMacros.h"
#import "NSMutableDictionary+Crash.h"

@implementation NSMutableDictionary (Crash)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(removeObjectForKey:) withMethod:@selector(safeRemoveObjectForKey:)];
        [obj swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(safeSetObject:forKey:)];
    });
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void) safeRemoveObjectForKey:(nonnull id) key
{
    @autoreleasepool{
        if(!key){
            XLOG(@"key is null.");
            return;
        }
        
        [self safeRemoveObjectForKey:key];
    }
    
}

- (void) safeSetObject:(nonnull id<NSCopying>) object forKey:(nonnull id) key
{
    @autoreleasepool{
        if(!object){
            XLOG(@"object is null.");
            return;
        }
        
        if(!key){
            XLOG(@"key is null.");
            return;
        }
        [self safeSetObject:object forKey:key];
    }
}

@end
