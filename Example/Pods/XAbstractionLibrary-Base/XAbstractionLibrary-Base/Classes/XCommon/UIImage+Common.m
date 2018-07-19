//
//  UIImage+Common.m
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/14.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
- (UIImage*) resizeInArea : (CGSize) area {
    CGSize size = self.size;
    
    if (size.width <= area.width && size.height <= area.height) return self;
    
    float tw = area.width / size.width;
    float th = area.height / size.height;
    float b =  tw < th ? tw : th;
    
    CGSize tmp = CGSizeMake(b*size.width, b*size.height);
    
    UIGraphicsBeginImageContext(tmp);
    
    CGRect imageRect = CGRectMake(0, 0, tmp.width, tmp.height);
    
    [self drawInRect:imageRect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
}
@end
