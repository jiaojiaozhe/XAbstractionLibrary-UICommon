//
//  CustomContentView1.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "CustomContentView1.h"

@interface CustomContentView1()
@property (nonatomic,strong) IBOutlet UILabel *contentTipLabel;
@end

@implementation CustomContentView1

+ (CustomContentView1 *) createCustomContentView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    CustomContentView1 *contentView = [[bundle loadNibNamed:className
                                                      owner:nil
                                                    options:nil] firstObject];
    return contentView;
}

@end
