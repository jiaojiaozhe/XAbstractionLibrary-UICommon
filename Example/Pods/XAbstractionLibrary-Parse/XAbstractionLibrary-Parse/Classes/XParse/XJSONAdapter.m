//
//  XJSONAdapter.m
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import "XModel.h"
#import "XJSONAdapter.h"

@implementation XJSONAdapter
+ (id)modelOfClass:(Class)modelClass fromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error
{
    id obj = [super modelOfClass:modelClass fromJSONDictionary:JSONDictionary error:error];
    if([modelClass respondsToSelector:@selector(JSONTransformerForValue:fromJSONDictionary:)])
        obj = [modelClass JSONTransformerForValue:obj fromJSONDictionary:JSONDictionary];
    return obj;
}

+ (NSDictionary *)JSONDictionaryFromModel:(id<MTLJSONSerializing>)model error:(NSError *__autoreleasing *)error
{
    NSDictionary *jsonDic = [super JSONDictionaryFromModel:model error:error];
    /**
     *  TODO:添加自定义操作
     */
    return jsonDic;
}

+ (NSString *) objectToJson:(id) object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id) jsonToObject:(NSString *) JSONString
{
    NSError *error = nil;
    if(!JSONString)
        return nil;
    
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    if(!jsonData){
        NSLog(@"error:json string error.");
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    
    return object;
}
@end
