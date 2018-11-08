//
//  DemoViewController1.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/6.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "DemoView.h"
#import "DemoViewController1.h"

@interface DemoViewController1 ()

@end

@implementation DemoViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (XView *)loadContentView{
    DemoView *demoView = [DemoView createView];
    return demoView;
}

@end
