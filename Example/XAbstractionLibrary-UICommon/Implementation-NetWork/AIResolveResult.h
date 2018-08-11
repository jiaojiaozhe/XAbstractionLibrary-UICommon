//
//  ResolveResult.h
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseResult.h"
#import <XAbstractionLibrary_Parse/XAbstractionLibrary-Parse-umbrella.h>

/**
 解析结果模型
 */
@interface AIResolveResult : XBaseModel


/**
 解析json数据到模型

 @param Class 指定模型的class
 @param resultObj json数据
 @param error 接口请求错误对象
 @return 返回解析后的结果
 */
+ (AIBaseResult *) resolveWithClass:(Class) Class
                          resultObj:(id) resultObj
                          error:(NSError *) error;
@end
