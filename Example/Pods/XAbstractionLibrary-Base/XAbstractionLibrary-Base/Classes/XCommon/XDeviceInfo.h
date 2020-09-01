//
//  XDeviceInfo.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/22.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import <Foundation/Foundation.h>

/**
 *  获得设备信息
 */
@interface XDeviceInfo : XData

/**
 *  获取设备的idfa，设备无法取得时，通过软生成产生唯一的，持久化处理过
 */
+ (NSString *) getDeviceIDFA;

/**
 *  获取设备的ifdv，取自设备本身，持久化处理过
 */
+ (NSString *) getDeviceIDFV;

/**
 *  清除keychain中app的所有缓存信息
 */
+ (void) removeAllCache;

/**
 *  获取操作系统版本
 */
+ (NSString *) getOSVersion;

/**
 *  获取屏幕宽度
 */
+ (NSNumber *) screenWidth;

/**
 *  获取屏幕高度
 */
+ (NSNumber *) screenHeight;

/**
 *  获取MAC地址
 */
+ (NSString *)macAddress;

/**
 *  获取设备静态IP地址(局域网)
 */
+ (NSString *)getDeviceIPAddresses;

/**
 *  获取手机外网IP地址
 */
+(NSString *)deviceWANIPAddress;

/**
 *  获取机器型号
 */
+ (NSString *)machineModel;

/**
 *  获取机器型号名称
 */
+ (NSString *)machineModelName;

/**
 *  对低端机型的判断
 */
+ (BOOL)isLowLevelMachine;

/**
 *  设备可用空间
 *  freespace/1024/1024/1024 = B/KB/MB/14.02GB
 */
+(NSNumber *)freeSpace;

/**
 *  设备总空间
 */
+(NSNumber *)totalSpace;

/**
 *  获取运营商信息
 */
+ (NSString *)carrierName;

/**
 *  获取运营商代码
 */
+ (NSString *)carrierCode;

/**
 *  获取电池电量
 */
+ (CGFloat) getBatteryValue;

/**
 *  获取电池状态
 */
+ (NSInteger) getBatteryState;

/**
 *  是否能发短信 不准确
 */
+ (BOOL) canDeviceSendMessage;

/**
 *  获取可用内存信息
 */
+ (unsigned long)freeMemory;

/**
 *  获取已用内存信息
 */
+ (unsigned long)usedMemory;

/**
 *  CPU总数目
 */
+ (NSUInteger) getCPUCount;

/**
 *  CPU使用比例
 */
+ (float) getCPUUsage;

/**
 *  获取每个CPU的使用比例
 */
+ (NSArray *) getPerCPUUsage;
@end
