//
//  MainViewController.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "MainViewController.h"
#import "TabBarViewController.h"

@interface MainViewController ()
@property (nonatomic,strong) TabBarViewController *tabBarController;
@end

@implementation MainViewController

- (instancetype) init{
    if(self = [super init]){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BOOL bLoaded = NO;
    NSArray *viewControllers = [self.navigationController viewControllers];
    for(NSUInteger index = 0; index < [viewControllers count]; index++){
        UIViewController *viewController = [viewControllers objectAtIndex:index];
        if(viewController == self.tabBarController &&
           [viewController isKindOfClass:[TabBarViewController class]]){
            bLoaded = YES;
            break;
        }
    }
    
    if(!bLoaded){
        self.tabBarController = [[TabBarViewController alloc] init];
        [self.navigationController pushViewController:self.tabBarController animated:NO];
    }
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

@end
