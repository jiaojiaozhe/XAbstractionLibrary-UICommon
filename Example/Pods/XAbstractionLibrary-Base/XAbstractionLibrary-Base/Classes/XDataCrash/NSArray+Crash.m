//
//  NSArray+Crash.m
//  XAbstractionLibrary-Base
//
//  Created by lanbiao on 2018/7/16.
//

#import <objc/runtime.h>
#import "XGlobalMacros.h"
#import "NSArray+Crash.h"

@implementation NSArray (Crash)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:) obj:obj];
    });
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector obj:(id) obj
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

- (id)safeObjectAtIndex:(NSInteger)index
{
    @autoreleasepool{
        if(index <= [self count] - 1 && index >= 0){
            return [self safeObjectAtIndex:index];
        }else{
            XLOG(@"index is beyond bounds.");
        }
        return NULL;
    }
}

@end
