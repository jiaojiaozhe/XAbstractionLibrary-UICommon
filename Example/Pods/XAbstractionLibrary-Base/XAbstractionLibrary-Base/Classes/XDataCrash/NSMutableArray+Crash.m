//
//  NSMutableArray+Crash.m
//  XAbstractionLibrary-Base
//
//  Created by lanbiao on 2018/7/16.
//

#import <objc/runtime.h>
#import "XGlobalMacros.h"
#import "NSMutableArray+Crash.h"

@implementation NSMutableArray (Crash)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeAddObject:)];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeObjectAtIndex:)];
        [obj swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(safeInsertObject:atIndex:)];
        [obj swizzleMethod:@selector(insertObjects:atIndexes:) withMethod:@selector(safeInsertObjects:atIndexes:)];
        [obj swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeRemoveObjectAtIndex:)];
        [obj swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(safeReplaceObjectAtIndex:withObject:)];
    });
}

- (void)safeAddObject:(id)anObject
{
    @autoreleasepool{
        if (anObject) {
            [self safeAddObject:anObject];
        }else{
            XLOG(@"object is nil.");
        }
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
        return nil;
    }
}

- (void) safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    @autoreleasepool{
        if(!anObject){
            XLOG(@"object is nil!");
            return;
        }
        
        if(index >= [self count] + 1){
            XLOG(@"index too max!");
            return;
        }
        
        [self safeInsertObject:anObject atIndex:index];
    }
}

- (void) safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    @autoreleasepool{
        if(!objects || [objects count] <= 0){
            XLOG(@"object is empty!");
            return;
        }
        
        [self safeInsertObjects:objects atIndexes:indexes];
    }
}

- (void) safeRemoveObjectAtIndex:(NSUInteger) index
{
    @autoreleasepool{
        if(index > [self count] - 1)
        {
            XLOG(@"index too max!");
            return;
        }
        
        [self safeRemoveObjectAtIndex:index];
    }
}

- (void) safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @autoreleasepool{
        if(!anObject){
            XLOG(@"object is nil.");
            return;
        }
        
        if(index > [self count] - 1)
        {
            XLOG(@"index too max.");
            return;
        }
        
        [self safeReplaceObjectAtIndex:index withObject:anObject];
    }
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
@end
