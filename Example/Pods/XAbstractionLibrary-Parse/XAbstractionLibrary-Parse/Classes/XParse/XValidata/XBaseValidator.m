//
//  XBaseValidator.m
//
//  Created by lanbiao on 18/7/21.
//  Copyright (c) 2018年 lanbiao. All rights reserved.
//

#import "XModel.h"
#import "XBaseValidator.h"
#import "XIntTypeValidator.h"
#import "XDataTypeValidator.h"
#import "XCharTypeValidator.h"
#import "XDateTypeValidator.h"
#import "XFloatTypeValidator.h"
#import "XArrayTypeValidator.h"
#import "XUnknowTypeValidator.h"
#import "XDoubleTypeValidator.h"
#import "XStringTypeValidator.h"
#import "XNumberTypeValidator.h"
#import "XBooleanTypeValidator.h"
#import "XIntergerTypeValidator.h"
#import "XCompositeTypeValidator.h"
#import "XDictionaryTypeValidator.h"
#import "XUnsignedCharTypeValidator.h"
#import "XMutableArrayTypeValidator.h"
#import "XMutableStringTypeValidator.h"
#import "XUnsignedIntegerTypeValidator.h"
#import "XMutableDictionaryTypeValidator.h"


@implementation XBaseValidator

+ (MTLValueTransformer *) validatorType:(NSString *) typeClassName
{
    MTLValueTransformer *valueTransformer = nil;
    Class class = NSClassFromString(typeClassName);
    NSArray *compositeClass = [typeClassName componentsSeparatedByString:@"_"];
    if(compositeClass.count > 1){
        valueTransformer = [XCompositeTypeValidator mtl_CustomJSONArrayTransformerWithModelClass:class];
    }
    else{
        compositeClass = [typeClassName componentsSeparatedByString:@"$"];
        if(compositeClass.count > 1){
            valueTransformer = [XCompositeTypeValidator mtl_CustomJSONDictionaryTransformerWithModelClass:class];
        }
        else{
            valueTransformer = [class validatorType];
        }
    }
    
    return valueTransformer;
}
@end
