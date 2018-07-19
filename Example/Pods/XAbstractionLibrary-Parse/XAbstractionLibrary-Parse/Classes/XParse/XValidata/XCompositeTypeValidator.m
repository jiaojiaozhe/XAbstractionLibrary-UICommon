//
//  XCompositeTypeValidator.m
//  Pods
//
//  Created by lanbiao on 18/7/22.
//
//

#import "XModel.h"
#import "XJSONAdapter.h"
#import "XCompositeTypeValidator.h"

@implementation XCompositeTypeValidator

+ (Class) mtl_customClassForParsingJSONDictionary:(NSDictionary *) JSONDictionary modelClass:(Class) cls
{
    if ([cls respondsToSelector:@selector(classForParsingJSONDictionary:)]) {
        cls = [cls classForParsingJSONDictionary:JSONDictionary];
        if (cls == nil) {
            return nil;
        }
        
        NSAssert([cls isSubclassOfClass:MTLModel.class], @"Class %@ returned from +classForParsingJSONDictionary: is not a subclass of MTLModel", cls);
        NSAssert([cls conformsToProtocol:@protocol(MTLJSONSerializing)], @"Class %@ returned from +classForParsingJSONDictionary: does not conform to <MTLJSONSerializing>", cls);
    }
    return cls;
}

+ (MTLValueTransformer *)mtl_CustomJSONDictionaryTransformerWithModelClass:(Class)modelClass
{
    NSParameterAssert([modelClass isSubclassOfClass:MTLModel.class]);
    NSParameterAssert([modelClass conformsToProtocol:@protocol(MTLJSONSerializing)]);
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value == nil) return nil;
        
        NSAssert([value isKindOfClass:NSDictionary.class], @"Expected a dictionary, got: %@", value);
        
        Class newClass = [self mtl_customClassForParsingJSONDictionary:value modelClass:modelClass];
        
        return [XJSONAdapter modelOfClass:newClass fromJSONDictionary:value error:NULL];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value == nil) return nil;
        
        NSAssert([value isKindOfClass:MTLModel.class], @"Expected a MTLModel object, got %@", value);
        NSAssert([value conformsToProtocol:@protocol(MTLJSONSerializing)], @"Expected a model object conforming to <MTLJSONSerializing>, got %@", value);
        
        return [XJSONAdapter JSONDictionaryFromModel:value error:nil];
    }];
}

+ (MTLValueTransformer *) mtl_CustomJSONArrayTransformerWithModelClass:(Class) cls
{
    NSValueTransformer *dictionaryTransformer = [self mtl_CustomJSONDictionaryTransformerWithModelClass:cls];
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value == nil) return nil;
        
        NSAssert([value isKindOfClass:NSArray.class], @"Expected an array of dictionaries, got: %@", value);
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
        for (id JSONDictionary in value) {
            if (JSONDictionary == NSNull.null) {
                [models addObject:NSNull.null];
                continue;
            }
            
            NSAssert([JSONDictionary isKindOfClass:NSDictionary.class], @"Expected a dictionary or an NSNull, got: %@", JSONDictionary);
            id model = [dictionaryTransformer transformedValue:JSONDictionary];
            if (model == nil)
                continue;
            [models addObject:model];
        }
        return models;
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value == nil) return nil;
        
        NSAssert([value isKindOfClass:NSArray.class], @"Expected an array of MTLModels, got: %@", value);
        
        NSMutableArray *dictionaries = [NSMutableArray arrayWithCapacity:0];
        for (id model in value) {
            if (model == NSNull.null) {
                [dictionaries addObject:NSNull.null];
                continue;
            }
            
            NSAssert([model isKindOfClass:MTLModel.class], @"Expected an MTLModel or an NSNull, got: %@", model);
            
            
            NSDictionary *dict = [dictionaryTransformer reverseTransformedValue:model];
            if (dict == nil) continue;
            
            [dictionaries addObject:dict];
        }
        
        return dictionaries;
    }];
}

@end
