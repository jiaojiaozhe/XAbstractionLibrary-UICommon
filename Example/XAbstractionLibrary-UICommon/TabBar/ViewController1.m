//
//  ViewController1.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController6.h"
#import "NavigationControllerManager.h"

@interface ViewController1 ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) click1:(id) sender{
    ViewController6 *viewController = [[ViewController6 alloc] init];
    [[NavigationControllerManager sharePageManager] pushViewControllerOnMain:viewController animated:YES];
}

- (IBAction) click2:(id) sender{
    ViewController6 *viewController = [[ViewController6 alloc] init];
    [[NavigationControllerManager sharePageManager] pushViewControllerOnTab:viewController animated:YES];
}


@end
