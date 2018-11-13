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

- (XView *) loadViewPresenter{
    DemoView *demoView = [DemoView createView];
    return demoView;
}

- (UIView *)getHeadLeftView {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    //    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    backBtn.frame = CGRectMake(0, 0, 16, 16);
    //    [backBtn setCenterFromView:leftView];
    //    [backBtn setEnlargeEdge:20];
    //    [backBtn addTarget:self action:@selector(onBackPage) forControlEvents:UIControlEventTouchUpInside];
    //    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    //    [leftView addSubview:backBtn];
    leftView.backgroundColor = [UIColor redColor];
    return leftView;
}

- (UIView *)getHeadCenterView{
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    centerView.backgroundColor = [UIColor yellowColor];
    return centerView;
}

- (UIView *)getHeadRightView{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    rightView.backgroundColor = [UIColor blueColor];
    return rightView;
}

@end
