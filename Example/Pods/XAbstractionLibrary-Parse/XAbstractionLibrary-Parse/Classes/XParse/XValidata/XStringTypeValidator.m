//
//  XStringTypeValida.m
//  Pods
//
//  Created by lanbiao on 18/07/31.
//
//

#import "XStringTypeValidator.h"

@implementation XStringTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error)
    {
        NSString *transform = [NSString stringWithFormat:@"XStringDefaultValue"];
        if(value){
            if([value isKindOfClass:[NSString class]])
                transform = [NSString stringWithString:value];
            else if([value respondsToSelector:@selector(stringValue)])
                transform = [NSString stringWithString:[value stringValue]];
        }
        return transform;
    };
    
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
