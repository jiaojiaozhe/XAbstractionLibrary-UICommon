//
//  XNonRetainObject.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/21.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XNonRetainObject_h
#define XAbstractionLibrary_XNonRetainObject_h

/**
 *  创建一个不使用retain的NSMutableArray
 *
 *  @return NSMutableArray对象
 */
NSMutableArray* XCreateNonRetainingArray(void);

/**
 *  创建一个不使用retain的NSMutableDictionary
 *
 *  @return NSMutableDictionary对象
 */
NSMutableDictionary *XCreateNonRetainingDictionary(void);

#endif
