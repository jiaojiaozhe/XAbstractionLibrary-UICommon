//
//  XGlobalMacros.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/13.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XGlobalMacros_h
#define XAbstractionLibrary_XGlobalMacros_h

#import "XViewMacros.h"
#import "XWeakMacros.h"
#import "XDeviceMacros.h"
#import "XDataManangerMacro.h"
#import "XNotification_Action.h"

/**
 *  日志打印
 */
#define LOG(format, ...) NSLog((@"LOG INFO(f:%s l:%d)" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#ifdef DEBUG
#define XLOG(format, ...) LOG(format, ##__VA_ARGS__)
#else
#define XLOG(format, ...)
#endif

/**
 *  向字典中添加一对key-value，会做空处理
 */
#define DICT_PUT(dict, key, obj) \
if(dict != NULL && key != NULL && obj != NULL){\
if(![dict isKindOfClass:[NSMutableDictionary class]]){\
if([dict isKindOfClass:[NSDictionary class]]){\
dict = [NSMutableDictionary dictionaryWithDictionary:dict];\
}\
}\
dict[key] = obj;\
}

/**
 *  向数组中添加成员，会做空处理
 */
#define ARRAY_PUT(array,obj)\
if(array != NULL && obj != NULL){\
if(![array isKindOfClass:[NSMutableArray class]]){\
if([array isKindOfClass:[NSArray class]]){\
array = [NSMutableArray arrayWithArray:array];\
}\
}\
[array addObject:obj];\
}

/**
 *  颜色相关
 */
#define RGB_COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGB_COLORA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#endif
