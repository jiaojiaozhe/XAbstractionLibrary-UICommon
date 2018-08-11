//
//  DemoViewController2.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/9.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//
#import "DemoView2.h"
#import "DemoViewController2.h"

@interface DemoViewController2 ()

@end

@implementation DemoViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIView *)loadNavigationBar{
//    UIView *navigationBar = [[UIView alloc] init];
//    navigationBar.backgroundColor = RGB_COLOR(255, 0, 0);
//    SET_VIEW_HEIGHT(navigationBar, 100);
//    return navigationBar;
//}

- (XView *)loadContentView{
    DemoView2 *demoView2 = [DemoView2 createView];
    return demoView2;
}

@end
