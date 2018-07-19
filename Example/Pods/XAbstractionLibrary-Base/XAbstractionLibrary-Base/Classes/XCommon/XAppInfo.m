//
//  XAppInfo.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/22.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XAppInfo.h"

@implementation XAppInfo
+ (NSString *) getAppVersion
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

+ (NSString *) getAppBundleIdentifier{
    NSString *bundleIndentifer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    return bundleIndentifer;
}

+ (NSString *) getFromSource
{
    return @"0";//@"app store";
}
@end
