//
//  XDataManangerMacro.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 17/7/28.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XDataManangerMacro_h
#define XAbstractionLibrary_XDataManangerMacro_h

#import <UIKit/UIKit.h>

NS_INLINE NSString* getMethodName(SEL selector){
    NSString* methodName = NSStringFromSelector(selector);
    if ([methodName hasPrefix:@"set"]){
        if (methodName.length>3) {
            NSString* methodFirsrtChar = [methodName substringWithRange:NSMakeRange(3, 1)];
            NSString* theOther = methodName.length>4 ? [methodName substringFromIndex:4] : @"";
            NSRange divRange = [theOther rangeOfString:@":"];
            if (divRange.location != NSNotFound) {
                theOther = [theOther substringToIndex:divRange.location];
            }
            methodFirsrtChar = [methodFirsrtChar lowercaseString];
            NSString* retval = [NSString stringWithFormat:@"%@%@", methodFirsrtChar, theOther];
            return retval;
        }
    }
    return methodName;
}

#ifndef USER_DEFAULTS_STORAGE
#define USER_DEFAULTS_STORAGE(name, setName, type)\
@synthesize name = _##name;\
-(void)setName :(type)name{\
NSUserDefaults *udfs = [NSUserDefaults standardUserDefaults];\
if ([_##name isEqual:name])return;\
NSString* key = [NSString stringWithFormat:@"%@.%@", NSStringFromClass(self.class), getMethodName(_cmd)];\
_##name = name;\
if (name) {\
[udfs setValue:name forKey:key];\
} else {\
[udfs removeObjectForKey:key];\
}\
[udfs synchronize];\
}\
\
- (type)name{\
NSUserDefaults *udfs = [NSUserDefaults standardUserDefaults];\
NSString* key = [NSString stringWithFormat:@"%@.%@", NSStringFromClass(self.class), getMethodName(_cmd)];\
if (!_##name) {\
_##name = [udfs objectForKey:key];\
}\
return _##name;\
}
#endif

#endif
