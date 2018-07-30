//
//  XBaseModel.m
//  Mantle
//
//  Created by lanbiao on 2018/7/13.
//

#import "XBaseModel.h"

@implementation XBaseModel
+ (NSString *) uuid
{
    NSString *ID = nil;
    static NSUInteger index = 0;
    static NSString *clientID = nil;
    
    @synchronized(XBaseModel.class)
    {
        if(clientID.length <= 0){
            clientID = [XDeviceInfo getDeviceIDFA];
        }
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *uuid = [NSString stringWithFormat:@"XID_%@_%lf_%lu",clientID,interval,(unsigned long)++index];
        ID = [XMD5Digest md5:uuid];
    }
    return ID;
}

- (instancetype) init
{
    if(self = [super init]){
        _ID = [XBaseModel uuid];
    }
    return self;
}

- (BOOL) validateID
{
    if(_ID.length <= 0)
        return NO;
    else
        return YES;
}

#pragma mark --
#pragma mark --预埋处理
+ (BOOL) validity
{
    return YES;
}

#pragma mark --
#pragma mark --NSCopying
//- (id)copyWithZone:(NSZone *)zone
//{
//    XBaseModel *newBaseModel = [[[self class] allocWithZone:zone] init];
//    newBaseModel.ID = [self.ID copy];
//    return newBaseModel;
//}

#pragma mark --
#pragma mark --NSCoding
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [super encodeWithCoder:aCoder];
//    if([self validateID])
//        [aCoder encodeObject:_ID forKey:@"ID"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    XBaseModel *baseModel = [super initWithCoder:aDecoder];
//    if([aDecoder containsValueForKey:@"ID"])
//        _ID = [aDecoder decodeObjectForKey:@"ID"];
//    return baseModel;
//}
@end
