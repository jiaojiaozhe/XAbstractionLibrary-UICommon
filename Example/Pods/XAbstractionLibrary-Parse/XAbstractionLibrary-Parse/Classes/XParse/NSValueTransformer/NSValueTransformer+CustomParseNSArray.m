//
//  NSValueTransformer+CustomParseNSArray.m
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import "XMantle.h"
#import "XJSONAdapter.h"
#import "NSValueTransformer+CustomParseNSArray.h"
#import "NSValueTransformer+CustomParseDictionary.h"

@implementation NSValueTransformer (CustomParseNSArray)
+ (NSValueTransformer *)mtl_CustomJSONArrayTransformerWithModelClass:(Class)modelClass {
    NSValueTransformer *dictionaryTransformer = [NSValueTransformer mtl_CustomJSONDictionaryTransformerWithModelClass:modelClass];
    
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
            if (model == nil) continue;
            
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
