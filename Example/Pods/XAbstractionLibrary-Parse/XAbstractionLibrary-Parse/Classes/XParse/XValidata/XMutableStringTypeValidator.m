//
//  XMutableStringTypeValidator.m
//  Pods
//
//  Created by lanbiao on 18/7/21.
//
//

#import "XMutableStringTypeValidator.h"

@implementation XMutableStringTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error)
    {
        NSMutableString *transform = [NSMutableString stringWithString:XStringDefaultValue];
        if(value){
            if([value isKindOfClass:[NSString class]])
                transform = [NSMutableString stringWithString:value];
            else if([value respondsToSelector:@selector(stringValue)])
                transform = [NSMutableString stringWithString:[value stringValue]];
        }
        return transform;
    };
    
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
