//
//  AIDiscoverViewController.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/2.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIDiscoverViewPresenter.h"
#import "AIDiscoverViewController.h"

@interface AIDiscoverViewController ()

@end

@implementation AIDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (XView *) loadViewPresenter{
    AIDiscoverViewPresenter *discoverViewPresenter = [AIDiscoverViewPresenter createView];
    return discoverViewPresenter;
}

@end
