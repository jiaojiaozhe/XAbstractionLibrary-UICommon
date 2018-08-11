//
//  DemoViewController3.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/10.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "DemoView3.h"
#import "DemoViewController3.h"

@interface DemoViewController3 ()

@end

@implementation DemoViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (XView *)loadContentView{
    DemoView3 *demoView3 = [DemoView3 createView];
    return demoView3;
}

@end
