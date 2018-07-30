//
//  XNetWorkStatus.h
//  XAbstractionLibrary-NetWork
//
//  Created by lanbiao on 2018/7/23.
//

#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

/**
 *  网络状态变化的全局消息，默认XView和XViewController的注册了该消息
 */
#define                 NETWORK_CHANGE_NOTIFICATION     @"NetWork_Change_Notifition"

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    
    /**
     *  未知状态
     */
    NetworkReachabilityStatusUnknown          = -1,
    
    /**
     *  无网
     */
    NetworkReachabilityStatusNotReachable     = 0,
    
    /**
     *  移动网络
     */
    NetworkReachabilityStatusReachableViaWWAN = 1,
    
    /**
     *  wifi
     */
    NetworkReachabilityStatusReachableViaWiFi = 2,
};

/**
 *  网络状态处理
 */
@interface XNetWorkStatus : XData

/**
 *  网络是否正常
 */
@property (nonatomic,assign) BOOL bGoodNet;

/**
 *  当前网络状态
 */
@property (nonatomic,assign) NetworkReachabilityStatus netWorkStatus;

/**
 *  单利对象方法
 */
+ (instancetype) shareNetkStatus;

@end
