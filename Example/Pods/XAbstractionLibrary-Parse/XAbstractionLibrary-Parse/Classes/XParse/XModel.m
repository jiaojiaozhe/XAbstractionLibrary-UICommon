//
//  XModel.m
//  Mantle
//
//  Created by lanbiao on 2018/7/13.
//

#import "XModel.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "XBaseValidator.h"
#import <Mantle/EXTRuntimeExtensions.h>
#import "XAbstractionLibrary-Base-umbrella.h"
#import "NSValueTransformer+CustomParseNSArray.h"
#import "NSValueTransformer+CustomParseDictionary.h"

@implementation XModel

static NSDictionary *propertyTypesList = nil;

+ (void)load
{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
        //NSInteger与long、NSUInteger与unsigned long、CGFloat与double等价
        propertyTypesList = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                        @"XIntTypeValidator",
                                                                        @"XFloatTypeValidator",
                                                                        @"XStringTypeValidator",
                                                                        @"XMutableStringTypeValidator",
                                                                        @"XBooleanTypeValidator",
                                                                        @"XNumberTypeValidator",
                                                                        @"XIntergerTypeValidator",
                                                                        @"XArrayTypeValidator",
                                                                        @"XMutableArrayTypeValidator",
                                                                        @"XDictionaryTypeValidator",
                                                                        @"XMutableDictionaryTypeValidator",
                                                                        @"XDateTypeValidator",
                                                                        @"XDoubleTypeValidator",
                                                                        @"XUnsignedIntegerTypeValidator",
                                                                        @"XDataTypeValidator",
                                                                        @"XUnknowTypeValidator",
                                                                        nil]
                                                               forKeys:[NSArray arrayWithObjects:
                                                                        [NSString stringWithFormat:@"%s",@encode(int)],
                                                                        [NSString stringWithFormat:@"%s",@encode(float)],
                                                                        @"NSString",
                                                                        @"NSMutableString",
                                                                        [NSString stringWithFormat:@"%s",@encode(BOOL)],
                                                                        @"NSNumber",
                                                                        [NSString stringWithFormat:@"%s",@encode(NSInteger)],//long等价
                                                                        @"NSArray",
                                                                        @"NSMutableArray",
                                                                        @"NSDictionary",
                                                                        @"NSMutableDictionary",
                                                                        @"NSDate",
                                                                        [NSString stringWithFormat:@"%s",@encode(double)],//CGFloat等价
                                                                        [NSString stringWithFormat:@"%s",@encode(NSUInteger)],//与unsigned long等价
                                                                        @"NSData",
                                                                        @"Unknown",
                                                                        nil]];
#else
        propertyTypesList = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                        @"XStringTypeValidator",
                                                                        @"XMutableStringTypeValidator",
                                                                        @"XBooleanTypeValidator",
                                                                        @"XNumberTypeValidator",
                                                                        @"XIntergerTypeValidator",
                                                                        @"XFloatTypeValidator",
                                                                        @"XArrayTypeValidator",
                                                                        @"XMutableArrayTypeValidator",
                                                                        @"XDictionaryTypeValidator",
                                                                        @"XMutableDictionaryTypeValidator",
                                                                        @"XDateTypeValidator",
                                                                        @"XDoubleTypeValidator",
                                                                        @"XUnsignedIntegerTypeValidator",
                                                                        @"XDataTypeValidator",
                                                                        @"XUnknowTypeValidator",
                                                                        nil]
                                                               forKeys:[NSArray arrayWithObjects:
                                                                        @"NSString",
                                                                        @"NSMutableString",
                                                                        [NSString stringWithFormat:@"%s",@encode(BOOL)],
                                                                        @"NSNumber",
                                                                        [NSString stringWithFormat:@"%s",@encode(NSInteger)],
                                                                        [NSString stringWithFormat:@"%s",@encode(CGFloat)],
                                                                        @"NSArray",
                                                                        @"NSMutableArray",
                                                                        @"NSDictionary",
                                                                        @"NSMutableDictionary",
                                                                        @"NSDate",
                                                                        [NSString stringWithFormat:@"%s",@encode(double)],
                                                                        [NSString stringWithFormat:@"%s",@encode(NSUInteger)],
                                                                        @"NSData",
                                                                        @"Unknown",
                                                                        nil]];
#endif
    });
}

/**
 *  获取指定属性的类型
 */
+ (NSString *)getPropertyType:(objc_property_t)property {
    if (!property) {
        return nil;
    }
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    NSData *propertyType = nil;
    while ((attribute = strsep(&state, ",")) != NULL){
        if (attribute[0] == 'T' && attribute[1] != '@') {
            propertyType = [NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1];
        } else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            propertyType = [NSData dataWithBytes:"id" length:2];
        } else if (attribute[0] == 'T' && attribute[1] == '@') {
            propertyType = [NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4];
        }
    }
    
    return [[NSString alloc] initWithData:propertyType encoding:NSUTF8StringEncoding];
}

/**
 *  获取指定类类型以及父类的所有属性key集合
 */
+ (NSDictionary *) getAllKey:(Class) cls{
    @autoreleasepool{
        NSMutableDictionary *allKeys = [NSMutableDictionary dictionary];
        if(cls == NULL)
            return allKeys;
        if([NSStringFromClass(cls) isEqualToString:@"NSObject"])
            return allKeys;
        if([NSStringFromClass(cls) isEqualToString:@"MTLModel"])
            return allKeys;
        if([NSStringFromClass(cls) isEqualToString:@"XModel"])
            return allKeys;
        Class superClass = [cls superclass];
        [allKeys addEntriesFromDictionary:[self getAllKey:superClass]];
        
        unsigned int outCount = 0;
        objc_property_t *propertys = class_copyPropertyList(cls, &outCount);
        for(unsigned int i = 0; i < outCount; i++)
        {
            objc_property_t property = propertys[i];
            const char *progertyName = property_getName(property);
            
            mtl_propertyAttributes *attributes = mtl_copyPropertyAttributes(property);
            if (attributes->readonly && attributes->ivar == NULL){
                continue;
            }
            
            NSString *encodeName = [[NSString alloc] initWithCString:progertyName encoding:NSUTF8StringEncoding];
            allKeys[encodeName] = encodeName;
        }
        return allKeys;
    }
}

+ (NSString *) getObjectProtocolName:(NSString *) typeName
                      classSeparated:(NSString *) classSeparated
{
    NSMutableArray *protocolNames = [NSMutableArray arrayWithArray:[typeName componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]];
    [protocolNames removeObjectAtIndex:0];
    for(NSInteger index = [protocolNames count] - 1;index >= 0; index--)
    {
        @autoreleasepool {
            NSString *protocaolName = [protocolNames objectAtIndex:index];
            NSString *temp = [protocaolName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if(temp.length <= 0)
            {
                [protocolNames removeObjectAtIndex:index];
            }
        }
    }
    
    return [protocolNames componentsJoinedByString:classSeparated];;
}

#pragma mark --
#pragma mark MTLJSONSerializing

/**
 *  返回当前类的成员集合，用于解析数据(仅限于被解析josn数据的键值与该类一致时，否则需要在重载该接口自定义)
 *
 *  @return 字典集合
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [self getAllKey:[self class]];
}

+ (NSValueTransformer*)JSONTransformerForKey:(NSString*)key
{
    NSValueTransformer *valueTransformer = nil;
    objc_property_t p = class_getProperty([self class], key.UTF8String);
    NSString *typeName = [self getPropertyType:p];
    NSString *typeNameClass = [propertyTypesList objectForKey:typeName];
    if(typeNameClass)
    {
        /**
         *  基础类型的安全性解析验证
         */
        valueTransformer = [XBaseValidator validatorType:typeNameClass];
    }
    else
    {
        /**
         *  非基础类型的安全性解析验证
         */
        Class subClass = NSClassFromString(typeName);
        if(subClass)
        {
            if([subClass isSubclassOfClass:[MTLModel class]] &&
               [subClass conformsToProtocol:@protocol(MTLJSONSerializing)])
            {
                /**
                 *  用于model内部的model的解析，并且可能添加到内存池.
                 */
                valueTransformer = [NSValueTransformer  mtl_CustomJSONDictionaryTransformerWithModelClass:subClass];
            }
            else
            {
                /**
                 *  不支持mantle解析规范的其它对象.
                 */
                valueTransformer = [XBaseValidator validatorType:@"XUnknowTypeValidator"];
            }
        }
        else
        {
            if(![typeName hasPrefix:@"NSArray"] &&
               ![typeName hasPrefix:@"NSMutableArray"])
            {
                NSString *protocolNames = [self getObjectProtocolName:typeName
                                                       classSeparated:@"$"];
                
                NSRange range = [protocolNames rangeOfString:@"$"];
                if(range.location != NSNotFound)
                {
                    if(!objc_lookUpClass([protocolNames UTF8String]))
                    {
                        Class newClass = objc_allocateClassPair([self class], [protocolNames UTF8String], 0);
                        if(!class_conformsToProtocol(newClass, NSProtocolFromString(@"MTLJSONSerializing")))
                            class_addProtocol(newClass, NSProtocolFromString(@"MTLJSONSerializing"));
                        objc_registerClassPair(newClass);
                    }
                    valueTransformer = [XBaseValidator validatorType:protocolNames];
                }
                else
                {
                    subClass = NSClassFromString(protocolNames);
                    if([subClass isSubclassOfClass:[MTLModel class]] &&
                       [subClass conformsToProtocol:@protocol(MTLJSONSerializing)])
                    {
                        /**
                         *  继承自MTLModel并且实现了MTLJSONSerializing协议的对象
                         */
                        valueTransformer = [NSValueTransformer mtl_CustomJSONDictionaryTransformerWithModelClass:subClass];
                    }
                    else
                    {
                        /**
                         *  不支持mantle解析规范的其它对象
                         */
                        valueTransformer = [XBaseValidator validatorType:@"XUnknowTypeValidator"];
                    }
                }
            }
            else
            {
                /**
                 *  用于model中的数组中的model的解析
                 */
                NSString *protocolNames = [self getObjectProtocolName:typeName
                                                       classSeparated:@"_"];
                NSRange range = [protocolNames rangeOfString:@"_"];
                if(range.location != NSNotFound)
                {
                    /**
                     *  用于对数组中可能出现的多种model的兼容解析，这是对于mantle的缺陷补充.
                     */
                    if(!objc_lookUpClass([protocolNames UTF8String]))
                    {
                        Class newClass = objc_allocateClassPair([self class], [protocolNames UTF8String], 0);
                        if(!class_conformsToProtocol(newClass, NSProtocolFromString(@"MTLJSONSerializing")))
                            class_addProtocol(newClass, NSProtocolFromString(@"MTLJSONSerializing"));
                        objc_registerClassPair(newClass);
                    }
                    
                    valueTransformer = [XBaseValidator validatorType:protocolNames];
                }
                else
                {
                    /**
                     *  用于对数组中单一类型model的解析
                     */
                    subClass = NSClassFromString(protocolNames);
                    if([subClass isSubclassOfClass:[MTLModel class]] &&
                       [subClass conformsToProtocol:@protocol(MTLJSONSerializing)])
                    {
                        /**
                         *  继承自MTLModel并且实现了MTLJSONSerializing协议的对象
                         */
                        valueTransformer = [NSValueTransformer mtl_CustomJSONArrayTransformerWithModelClass:subClass];
                    }
                    else
                    {
                        /**
                         *  不支持mantle解析规范的其它对象
                         */
                        valueTransformer = [XBaseValidator validatorType:@"XUnknowTypeValidator"];
                    }
                }
            }
        }
    }
    return valueTransformer;
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary
{
    Class jsonClass = [self class];
    NSString *className = NSStringFromClass(jsonClass);
    NSArray *classList = [className componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"_$"]];
    if([classList count] >= 2)
    {
        CGFloat weights = 0.0f;
        for(NSString *clsName in classList)
        {
            Class cls = NSClassFromString(clsName);
            CGFloat clsWeights = [self weightsTraversalWithDictionary:JSONDictionary Class:cls];
            if(clsWeights >= weights)
            {
                weights = clsWeights;
                jsonClass = cls;
            }
        }
    }
    return jsonClass;
}

+ (CGFloat) weightsTraversalWithDictionary:(NSDictionary *) JSONDictionary Class:(Class) cls
{
    NSDictionary *progerts = [cls JSONKeyPathsByPropertyKey];
    NSArray *keyList = [progerts allValues];
    NSArray *jsonKeyList = [JSONDictionary allKeys];
    
    NSInteger index = 0,count = [progerts count];
    for(NSString *jsonKey in jsonKeyList)
    {
        for(NSString *key in keyList)
        {
            if([jsonKey isEqualToString:key])
            {
                index ++;
                break;
            }
        }
    }
    
    return (index * 1.0) / count;
}

@end
