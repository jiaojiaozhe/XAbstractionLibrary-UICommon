//
//  XPermanentStoreData.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/30.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XAppInfo.h"
#import "KeychainItemWrapper.h"
#import "XPermanentStoreData.h"

@implementation XPermanentStoreData

+ (BOOL) saveData:(id) value cacheKey:(id) cacheKey{
    if(cacheKey == NULL){
        return NO;
    }
    
    NSString *group = NULL;//[XAppInfo getAppBundleIdentifier];
    KeychainItemWrapper *keyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:cacheKey accessGroup:group];
    if(value != NULL)
        [keyChainItemWrapper setObject:value forKey:(id)kSecValueData];
    else
        [keyChainItemWrapper resetKeychainItem];
    
    return YES;
}

+ (id) dataFromKey:(id) cacheKey{
    if(cacheKey == NULL){
        return NULL;
    }
    
    id value = NULL;
    NSString *group = NULL;//[XAppInfo getAppBundleIdentifier];
    KeychainItemWrapper *keyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:cacheKey accessGroup:group];
    value = [keyChainItemWrapper objectForKey:(id)kSecValueData];
    
    return value;
}

+ (BOOL) saveStringToCache:(NSString *) value cacheKey:(NSString *)cacheKey
{
    if(!cacheKey)
        return NO;
    return [self saveData:value cacheKey:cacheKey];
}

+ (NSString *) valueFromCache:(NSString *) cacheKey
{
    if(!cacheKey)
        return nil;
    id data = [self dataFromKey:cacheKey];
    if(!data || [data isKindOfClass:[NSDictionary class]]){
        return NULL;
    }else{
        return data;
    }
}

+ (BOOL) saveModelToCache:(NSObject *) modelValue cacheKey:(NSString *)cacheKey
{
    if(!cacheKey)
        return NO;
    
    if(![modelValue isKindOfClass:[NSObject class]] ||
       ![modelValue conformsToProtocol:@protocol(NSCoding)])
        return NO;
    
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:modelValue];
    return [self saveData:modelData cacheKey:cacheKey];
}

+ (NSObject *) modelFromCacheKey:(NSString *) cacheKey
{
    if(!cacheKey)
        return nil;
    
    NSObject *modelValue = NULL;
    id data = [self dataFromKey:cacheKey];
    if(!data || [data isKindOfClass:[NSDictionary class]]){
        return NULL;
    }else{
        if([data isKindOfClass:[NSData class]]){
            NSData *modelData = (NSData*)data;
            modelValue = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        }
    }
    
    return modelValue;
}

+ (BOOL) removeCache:(NSString *) cacheKey{
    return [self saveData:NULL cacheKey:cacheKey];
}

@end
