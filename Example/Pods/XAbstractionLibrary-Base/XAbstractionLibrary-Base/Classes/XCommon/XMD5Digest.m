//
//  XMD5Digest.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/13.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XMD5Digest.h"
#import "NSString+MD5.h"

@implementation XMD5Digest

+ (NSString *) md5:(NSString *) digest
{
    return [digest MD5Digest];
}

@end
