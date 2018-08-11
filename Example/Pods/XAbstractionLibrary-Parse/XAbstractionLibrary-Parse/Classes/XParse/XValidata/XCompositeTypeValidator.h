//
//  XCompositeTypeValidator.h
//  Pods
//
//  Created by lanbiao on 18/7/22.
//
//

#import "XBaseValidator.h"

@interface XCompositeTypeValidator : XBaseValidator

/**
 *  用于对合并类型进行的解析，具体点说就是数组中包含多种类型的情况下
 *
 *  @param cls 组合类类型
 *
 *  @return 返回解析和逆解析的Transformer
 */
+ (MTLValueTransformer *) mtl_CustomJSONArrayTransformerWithModelClass:(Class) cls;

/**
 *  用于对合并类型进行的解析，具体点说就是对对象类型的各继承子类的解析支持
 *
 *  @param modelClass 组合类类型
 *
 *  @return 返回解析和逆解析的Transformer
 */
+ (MTLValueTransformer *)mtl_CustomJSONDictionaryTransformerWithModelClass:(Class)modelClass;
@end
