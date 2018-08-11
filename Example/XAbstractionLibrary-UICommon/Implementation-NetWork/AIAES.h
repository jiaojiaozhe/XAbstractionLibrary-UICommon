//
//  AIAES.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIAES : NSObject
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;
+ (NSDictionary *)decryptAES:(NSString *)content key:(NSString *)key;
@end
