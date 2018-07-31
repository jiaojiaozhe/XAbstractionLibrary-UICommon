//
//  ViewController6.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "ViewController6.h"

@interface ViewController6 ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark --
#pragma mark --UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    NSArray *controllers = [self.navigationController viewControllers];
    if([controllers count] > 1)
        return YES;
    else
        return NO;
}

@end
