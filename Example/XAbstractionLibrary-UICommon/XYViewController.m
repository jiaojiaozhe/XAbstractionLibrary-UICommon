//
//  XViewController.m
//  XAbstractionLibrary-UICommon
//
//  Created by jiaojiaozhe on 07/16/2018.
//  Copyright (c) 2018 jiaojiaozhe. All rights reserved.
//

#import "BaseTableView.h"
#import "XYViewController.h"
#import "CustomView1.h"
#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>
@interface XYViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong) IBOutlet UIView *contentView;
@property (nonatomic,strong) IBOutlet XView *demoView;
@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.listStyle = XListViewStyleStandard;
    self.tableView.bAutoLoading = YES;
    
//    _demoView = [CustomView1 createView];
//    [self.contentView addSubview:_demoView];
//
//    _demoView.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_demoView
//                                                                     attribute:NSLayoutAttributeTop
//                                                                     relatedBy:NSLayoutRelationEqual
//                                                                        toItem:self.contentView
//                                                                     attribute:NSLayoutAttributeTop
//                                                                    multiplier:1.0f
//                                                                      constant:0];
//    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_demoView
//                                                                      attribute:NSLayoutAttributeLeft
//                                                                      relatedBy:NSLayoutRelationEqual
//                                                                         toItem:self.contentView
//                                                                      attribute:NSLayoutAttributeLeft
//                                                                     multiplier:1.0
//                                                                       constant:0.0f];
//    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_demoView
//                                                                        attribute:NSLayoutAttributeRight
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:self.contentView
//                                                                        attribute:NSLayoutAttributeRight
//                                                                       multiplier:1.0f
//                                                                         constant:0];
//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_demoView
//                                                                       attribute:NSLayoutAttributeBottom
//                                                                       relatedBy:NSLayoutRelationEqual
//                                                                          toItem:self.contentView
//                                                                       attribute:NSLayoutAttributeBottom
//                                                                      multiplier:1.0f
//                                                                        constant:0];
//    [self.contentView addConstraint:leftConstraint];
//    [self.contentView addConstraint:bottomConstraint];
//    [self.contentView addConstraint:rightConstraint];
//    [self.contentView addConstraint:topConstraint];
//    [_demoView setNeedsLayout];
//    [_demoView layoutIfNeeded];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) startLoad: (id)sender{
    
}

- (IBAction) loadSuccess: (id)sender{
    
}

- (IBAction) loadFail:(id) sender{
    
}


#pragma mark --
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

#pragma mark --
#pragma mak --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if(tableViewCell == NULL){
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"tableViewCell"];
        tableViewCell.backgroundColor = [UIColor redColor];
    }
    return tableViewCell;
    
}

@end
