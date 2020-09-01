//
//  XNetWorkStatus.m
//  XAbstractionLibrary-NetWork
//
//  Created by lanbiao on 2018/7/23.
//

#import "XNetWorkStatus.h"
#import "AFNetworkReachabilityManager.h"

@implementation XNetWorkStatus

#pragma mark --单例模式
+ (instancetype) shareNetkStatus
{
    static XNetWorkStatus *shareNetkStatus = nil;
#if !__has_feature(objc_arc)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetkStatus = [NSAllocateObject([self class], 0, nil) init];
    });
#else
    //    requestManager = [[[self class] alloc] init];
    shareNetkStatus = [[self class] alloc];
#endif
    return shareNetkStatus;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
#if !__has_feature(objc_arc)
    return [[self shareNetkStatus] retain];
#else
    static XNetWorkStatus *shareNetkStatus = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetkStatus = [[super allocWithZone:zone] init];
    });
    return shareNetkStatus;
#endif
}

#if !__has_feature(objc_arc)
- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

- (id) autorelease
{
    return self;
}

- (oneway void) release
{
    
}
#endif

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}


+ (void) load
{
    [XNetWorkStatus shareNetkStatus];
}


- (instancetype) init
{
    if(self = [super init]){
        self.bGoodNet = YES;
        __weak typeof(self) weakSelf = self;
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            XNetworkReachabilityStatus netStatus = XNetworkReachabilityStatusUnknown;
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    netStatus = XNetworkReachabilityStatusUnknown;
                    XLOG(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    netStatus = XNetworkReachabilityStatusNotReachable;
                    XLOG(@"失去网络连接");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    netStatus = XNetworkReachabilityStatusReachableViaWWAN;
                    XLOG(@"GPRS网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    netStatus = XNetworkReachabilityStatusReachableViaWiFi;
                    XLOG(@"WIFI网络");
                    break;
                default:
                    netStatus = XNetworkReachabilityStatusUnknown;
                    break;
            }
            weakSelf.netWorkStatus = netStatus;
            if(netStatus == XNetworkReachabilityStatusReachableViaWiFi || netStatus == XNetworkReachabilityStatusReachableViaWWAN){
                weakSelf.bGoodNet = YES;
            }else{
                weakSelf.bGoodNet = NO;
            }
            
            NSMutableDictionary *dataInfo = [NSMutableDictionary dictionary];
            DICT_PUT(dataInfo, NOTIFICATION_ACTION, @(XNotification_Action_NetWork));
            DICT_PUT(dataInfo, @"NetworkReachabilityStatus", @(netStatus));
            [[NSNotificationCenter defaultCenter] postNotificationName:GLOBAL_UI_ACTION_NOTIFICATION
                                                                object:nil
                                                              userInfo:dataInfo];
        }];
    }
    return self;
}

@end
