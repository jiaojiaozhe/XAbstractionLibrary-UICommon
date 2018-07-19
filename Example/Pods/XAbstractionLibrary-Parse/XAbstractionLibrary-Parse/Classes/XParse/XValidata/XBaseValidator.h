//
//  XBaseValidator.h
//
//  Created by lanbiao on 18/7/21.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XBaseModel.h"
#import "XDefaultValue.h"
#import "MTLValueTransformer.h"

@protocol XBaseValidator <NSObject>
@optional
+ (MTLValueTransformer *) validatorType;
@end

/**
 *  基础解析器
 */
@interface XBaseValidator : XBaseModel<XBaseValidator>
+ (MTLValueTransformer *) validatorType:(NSString *) typeClassName;
@end
