//
//  AIBaseViewController.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseViewController.h"

@interface AIBaseViewController ()

@end

@implementation AIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version >= 7.0){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        if(@available(iOS 11.3, *)){
            XLOG(@"aaa");
            //self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            //11.0以后的OS需要设置ScrollView的contentInsetAdjustmentBehavior
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)getHeadLeftView {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
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
