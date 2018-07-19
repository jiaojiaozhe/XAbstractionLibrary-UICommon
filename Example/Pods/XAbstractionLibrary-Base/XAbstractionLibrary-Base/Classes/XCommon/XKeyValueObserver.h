//
//  XKeyValueObserver.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/3/1.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import "XData.h"
#import <Foundation/Foundation.h>

@interface XKeyValueObserver : XData

/**
 *  构建观察者helper
 *
 *  @param object   被观察的对象
 *  @param keyPath  被观察的key
 *  @param target   观察者回调目标
 *  @param selector 观察者回调代码块
 *
 *  @return 返回观察者helper，并且要强引用该返回值，否则刚刚建立的观察者会被取消
 */
+ (NSObject*) observeObject:(id) object
                   keyPath:(NSString *) keyPath
                    target:(id) target
                  selector:(SEL) selector __attribute__ ((warn_unused_result));


/**
 *  构建观察者helper
 *
 *  @param object   被观察的对象
 *  @param keyPath  被观察的key
 *  @param target   观察者回调目标
 *  @param selector 观察者回调代码块
 *  @param option   选项值，与系统参数一致
 *
 *  @return 返回观察者helper，并且要强引用该返回值，否则刚刚建立的观察者会被取消
 */
+ (NSObject*) observeObject:(id) object
                   keyPath:(NSString *) keyPath
                    target:(id) target
                  selector:(SEL) selector
                   options:(NSKeyValueObservingOptions) option __attribute__ ((warn_unused_result));

@end
