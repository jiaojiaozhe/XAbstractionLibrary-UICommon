//
//  XNetWorkStatus.h
//  XAbstractionLibrary-NetWork
//
//  Created by lanbiao on 2018/7/23.
//

#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, XNetworkReachabilityStatus) {
    
    /**
     *  未知状态
     */
    XNetworkReachabilityStatusUnknown          = -1,
    
    /**
     *  无网
     */
    XNetworkReachabilityStatusNotReachable     = 0,
    
    /**
     *  移动网络
     */
    XNetworkReachabilityStatusReachableViaWWAN = 1,
    
    /**
     *  wifi
     */
    XNetworkReachabilityStatusReachableViaWiFi = 2,
};

/**
 *  网络状态处理
 */
@interface XNetWorkStatus : NSObject

/**
 *  网络是否正常
 */
@property (nonatomic,assign) BOOL bGoodNet;

/**
 *  当前网络状态
 */
@property (nonatomic,assign) XNetworkReachabilityStatus netWorkStatus;

/**
 *  单利对象方法
 */
+ (instancetype) shareNetkStatus;

@end
