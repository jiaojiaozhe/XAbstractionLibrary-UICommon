//
//  XKeyValueObserver.m
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/3/1.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import "XKeyValueObserver.h"

@interface XKeyValueObserver ()
@property (nonatomic,weak) id target;
@property (nonatomic,weak) id observedObject;
@property (nonatomic,copy) NSString *keyPath;
@property (nonatomic,assign) SEL selector;
@end

@implementation XKeyValueObserver

- (instancetype) initWithObject:(id) object
                        keyPath:(NSString *) keyPath
                         target:(id) target
                       selector:(SEL) selector
                         option:(NSKeyValueObservingOptions) option
{
    if(object == nil)
        return nil;
    
    NSParameterAssert(object != nil);
    NSParameterAssert(target != nil);
    NSParameterAssert([target respondsToSelector:selector]);
    if(self = [super init])
    {
        self.target = target;
        self.selector = selector;
        self.observedObject = object;
        self.keyPath = keyPath;
        [object addObserver:self
                 forKeyPath:keyPath
                    options:option
                    context:(__bridge void * _Nullable)(self)];
    }
    return self;
}

+ (NSObject *) observeObject:(id)object
                     keyPath:(NSString *)keyPath
                      target:(id)target
                    selector:(SEL)selector
{
    return [self observeObject:object
                       keyPath:keyPath
                        target:target
                      selector:selector
                       options:0];
}

+ (NSObject *) observeObject:(id)object
                     keyPath:(NSString *)keyPath
                      target:(id)target
                    selector:(SEL)selector
                     options:(NSKeyValueObservingOptions)option
{
    return [[self alloc] initWithObject:object
                                keyPath:keyPath
                                 target:target
                               selector:selector
                                 option:option];
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary<NSString *,id> *)change
                        context:(void *)context
{
    if(context == (__bridge void * _Nullable)(self))
    {
        [self didChange:change];
    }
}

- (void) dealloc
{
    if(self.observedObject)
        [self.observedObject removeObserver:self forKeyPath:self.keyPath];
}

#pragma mark 观察者回调
- (void) didChange:(NSDictionary *) changeInfo
{
    id strongTarget = self.target;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if([strongTarget respondsToSelector:self.selector])
        [strongTarget performSelector:self.selector
                           withObject:changeInfo];
#pragma clang diagnostic pop
}
@end
