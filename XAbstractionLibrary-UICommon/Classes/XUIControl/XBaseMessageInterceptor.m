//
//  XBaseMessageInterceptor.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import "XBaseMessageInterceptor.h"

@implementation XBaseMessageInterceptor
- (id) forwardingTargetForSelector:(SEL) aSelector
{
    if([_interceptor respondsToSelector:aSelector])
        return _interceptor;
    if([_delegateReceiver respondsToSelector:aSelector])
        return _delegateReceiver;
    if([_dataSourceReceiver respondsToSelector:aSelector])
        return _dataSourceReceiver;
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL) respondsToSelector:(SEL)aSelector
{
    if([_interceptor respondsToSelector:aSelector])
        return YES;
    if([_delegateReceiver respondsToSelector:aSelector])
        return YES;
    if([_dataSourceReceiver respondsToSelector:aSelector])
        return YES;
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if(!sig)
        sig = [_interceptor methodSignatureForSelector:aSelector];
    if(!sig)
        sig = [_delegateReceiver methodSignatureForSelector:aSelector];
    if(!sig)
        sig = [_dataSourceReceiver methodSignatureForSelector:aSelector];
    return sig;
}

- (void) forwardInvocation:(NSInvocation *)anInvocation
{
    SEL name = [anInvocation selector];
    if([_interceptor respondsToSelector:name])
        [anInvocation invokeWithTarget:_interceptor];
    else if([_delegateReceiver respondsToSelector:name])
        [anInvocation invokeWithTarget:_delegateReceiver];
    else if([_dataSourceReceiver respondsToSelector:name])
        [anInvocation invokeWithTarget:_dataSourceReceiver];
    else
        [super forwardInvocation:anInvocation];
}
@end
