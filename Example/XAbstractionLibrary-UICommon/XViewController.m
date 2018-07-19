//
//  XViewController.m
//  XAbstractionLibrary-UICommon
//
//  Created by jiaojiaozhe on 07/16/2018.
//  Copyright (c) 2018 jiaojiaozhe. All rights reserved.
//

#import "BaseTableView.h"
#import "XViewController.h"

@interface XViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) IBOutlet BaseTableView *tableView;
@end

@implementation XViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.listStyle = XListViewStyleStandard;
    self.tableView.bAutoLoading = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

#pragma mark --
#pragma mak --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    if(tableViewCell == NULL){
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:@"tableViewCell"];
    }
    return tableViewCell;
    
}

@end
