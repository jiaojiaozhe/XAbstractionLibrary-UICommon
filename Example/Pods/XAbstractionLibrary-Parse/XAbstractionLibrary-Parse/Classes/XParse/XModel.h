//
//  XModel.h
//  Mantle
//
//  Created by lanbiao on 2018/7/13.
//

#import <Mantle/Mantle.h>

@protocol XJSONAdapterSerializing <NSObject>
@optional
+ (id) JSONTransformerForValue:(id) value
            fromJSONDictionary:(NSDictionary *) JSONDictionary;
@end

/**
 *  基础解析model，支持容错性、多态性支持
 */
@interface XModel : MTLModel<MTLJSONSerializing,XJSONAdapterSerializing>

@end
