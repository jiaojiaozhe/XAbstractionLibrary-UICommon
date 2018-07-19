//
//  XPermanentStoreData.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/30.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "KeychainItemWrapper.h"
#import "XPermanentStoreData.h"

@implementation XPermanentStoreData

+ (BOOL) saveData:(id) value cacheKey:(id) cacheKey{
    if(cacheKey == NULL){
        return NO;
    }
    
#if TARGET_IPHONE_SIMULATOR
    
#else
    //不定义SIMULATOR_TEST这个宏
    KeychainItemWrapper *keyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:cacheKey accessGroup:NULL];
    if(value != NULL)
        [keyChainItemWrapper setObject:value forKey:cacheKey];
    else
        [keyChainItemWrapper resetKeychainItem];
#endif
    
    
    return YES;
}

+ (id) dataFromKey:(id) cacheKey{
    if(cacheKey != NULL){
        return NULL;
    }
    
    id value = NULL;
#if TARGET_IPHONE_SIMULATOR
    
#else
    KeychainItemWrapper *keyChainItemWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:cacheKey accessGroup:NULL];
    value = [keyChainItemWrapper objectForKey:cacheKey];
#endif
    
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
