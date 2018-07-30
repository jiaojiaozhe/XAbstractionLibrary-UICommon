//
//  CustomView1.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "CustomView1.h"
#import "CustomContentView1.h"

@implementation CustomView1

- (UIView *) getContentView{
    CustomContentView1 *customContentView = [CustomContentView1 createCustomContentView];
    
    return customContentView;
}

- (void) initView{
    
}

- (void) loadPage{
    
}

@end
