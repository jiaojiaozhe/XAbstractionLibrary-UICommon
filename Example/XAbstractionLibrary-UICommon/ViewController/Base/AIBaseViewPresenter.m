//
//  AIBaseContentView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseViewPresenter.h"

@implementation AIBaseViewPresenter

- (instancetype)init{
    self = [super init];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (UIView *)getContentView{
    return nil;
}

- (void)initView{
    
}

- (void)loadPage{
    
}

@end
