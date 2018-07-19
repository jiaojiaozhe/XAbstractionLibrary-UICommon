//
//  NSValueTransformer+CustomParseDictionary.h
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (CustomParseDictionary)
+ (NSValueTransformer *)mtl_CustomJSONDictionaryTransformerWithModelClass:(Class)modelClass;
@end
