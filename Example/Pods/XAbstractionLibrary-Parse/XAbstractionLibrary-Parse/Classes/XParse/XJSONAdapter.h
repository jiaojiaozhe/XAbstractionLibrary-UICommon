//
//  XJSONAdapter.h
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import <Mantle/Mantle.h>

@interface XJSONAdapter : MTLJSONAdapter
/**
 *  oc对象转json
 *
 *  @param object 待转oc对象
 *
 *  @return 返回json字符串
 */
+ (NSString *) objectToJson:(id) object;

/**
 *  json转oc对象
 *
 *  @param JSONString 待转json串
 *
 *  @return 返回oc对象
 */
+ (id) jsonToObject:(NSString *) JSONString;
@end
