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

- (UIView *)loadNavigationBar{
    UIView *navigationBar = [[UIView alloc] init];
    navigationBar.backgroundColor = RGB_COLOR(255, 0, 0);
    SET_VIEW_HEIGHT(navigationBar, 100);
    return navigationBar;
}

- (XView *)loadContentView{
    DemoView *demoView = [DemoView createView];
    return demoView;
}

@end
