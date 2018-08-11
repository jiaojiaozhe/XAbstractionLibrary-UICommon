//
//  ViewController1.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseView.h"
#import "ViewController1.h"
#import "ViewController6.h"
#import "DemoViewController1.h"
#import "DemoViewController2.h"
#import "DemoViewController3.h"
#import "NavigationControllerManager.h"

@interface ViewController1 ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) IBOutlet UIButton *btn;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BaseView *baseView = [BaseView createView];
    [self.view addSubview:baseView];
    [baseView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) click1:(id) sender{
    DemoViewController3 *controller3 = [[DemoViewController3 alloc] init];
    [[NavigationControllerManager sharePageManager] pushViewControllerOnMain:controller3 animated:YES];
    
//    DemoViewController1 *controller1 = [[DemoViewController1 alloc] init];
//    [[NavigationControllerManager sharePageManager] pushViewControllerOnMain:controller1 animated:YES];
    
//    DemoViewController2 *controller2 = [[DemoViewController2 alloc] init];
//    [[NavigationControllerManager sharePageManager] pushViewControllerOnMain:controller2 animated:YES];
    
//    ViewController6 *viewController = [[ViewController6 alloc] init];
//    [[NavigationControllerManager sharePageManager] pushViewControllerOnMain:viewController animated:YES];
}

- (IBAction) click2:(id) sender{
    ViewController6 *viewController = [[ViewController6 alloc] init];
    [[NavigationControllerManager sharePageManager] pushViewControllerOnTab:viewController animated:YES];
}


@end
