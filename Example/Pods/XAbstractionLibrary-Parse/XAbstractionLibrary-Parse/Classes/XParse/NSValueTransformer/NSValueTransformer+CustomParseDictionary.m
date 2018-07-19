//
//  NSValueTransformer+CustomParseDictionary.m
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//
#import "XMantle.h"
#import "XJSONAdapter.h"
#import "NSValueTransformer+CustomParseDictionary.h"
#import "NSValueTransformer+CustomParseDictionary.h"

@implementation NSValueTransformer (CustomParseDictionary)
+ (NSValueTransformer *)mtl_CustomJSONDictionaryTransformerWithModelClass:(Class)modelClass {
    NSParameterAssert([modelClass isSubclassOfClass:MTLModel.class]);
    NSParameterAssert([modelClass conformsToProtocol:@protocol(MTLJSONSerializing)]);
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value == nil)
            return nil;
        if(![value isKindOfClass:[NSDictionary class]])
            return nil;
        //        NSAssert([value isKindOfClass:NSDictionary.class], @"Expected a dictionary, got: %@", value);
        
        return [XJSONAdapter modelOfClass:modelClass fromJSONDictionary:value error:NULL];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value == nil) return nil;
        if(![value isKindOfClass:MTLModel.class])
            return nil;
        if(![value conformsToProtocol:@protocol(MTLJSONSerializing)])
            return nil;
        //        NSAssert([value isKindOfClass:MTLModel.class], @"Expected a MTLModel object, got %@", value);
        //        NSAssert([value conformsToProtocol:@protocol(MTLJSONSerializing)], @"Expected a model object conforming to <MTLJSONSerializing>, got %@", value);
        
        return [XJSONAdapter JSONDictionaryFromModel:value error:nil];
    }];
}
@end
