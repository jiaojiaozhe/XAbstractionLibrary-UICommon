//
//  NSValueTransformer+CustomParseNSArray.h
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (CustomParseNSArray)
+ (NSValueTransformer *)mtl_CustomJSONArrayTransformerWithModelClass:(Class)modelClass;
@end
