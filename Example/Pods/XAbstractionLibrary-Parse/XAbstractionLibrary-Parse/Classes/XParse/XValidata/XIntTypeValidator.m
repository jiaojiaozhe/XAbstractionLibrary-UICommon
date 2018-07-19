//
//  XIntTypeValidator.m
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import "XIntTypeValidator.h"

@implementation XIntTypeValidator
+ (MTLValueTransformer *) validatorType
{
    MTLValueTransformerBlock transFormerBlock = ^id (id value, BOOL *success, NSError **error){
        NSNumber *number = [NSNumber numberWithInt:XIntDefaultValue];
        if(value)
        {
            if([value isKindOfClass:[NSNumber class]])
                number = value;
            else if([value isKindOfClass:[NSString class]])
            {
                NSString *lower = [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                if([NSString isPureInt:lower])
                    number = [NSNumber numberWithInt:[lower intValue]];
                else if([NSString isPureFloat:lower])
                    number = [NSNumber numberWithInt:[lower intValue]];
                else if([NSString isPureDouble:lower])
                    number = [NSNumber numberWithInt:[lower intValue]];
            }
        }
        return number;
    };
    
    return [MTLValueTransformer transformerUsingForwardBlock:transFormerBlock reverseBlock:transFormerBlock];
}
@end
