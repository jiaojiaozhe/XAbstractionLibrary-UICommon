//
//  AIDiscoverViewPresenter.m
//  AiParkToC
//
//  Created by lanbiao on 2018/11/13.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIDiscoverViewPresenter.h"

@interface AIDiscoverViewPresenter()
@property (nonatomic,strong) NSMutableArray *dataList;
@end

@implementation AIDiscoverViewPresenter

- (void) initView{
    [super initView];
    _dataList = [NSMutableArray array];
    [self setBAutoLoading:YES];
    [self setBPreLoadMore:YES];
}

- (void)loadPage{
    
}

- (XBaseListViewStyle) getListStyle{
    return XBaseListViewStyleStandard;
}

- (void) refreshToDown:(UIScrollView *) scrollView{
    XLOG(@"下拉刷新");
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3.0f);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.dataList removeAllObjects];
            for(int index = 1; index <= 20; index++){
                [weakSelf.dataList addObject:@(index)];
            }
            [weakSelf refreshFinish:weakSelf.dataList bError:NO];
        });
    });
}

- (void) loadToMore:(UIScrollView *) scrollView{
    XLOG(@"上拉加载更多");
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3.0f);
        dispatch_async(dispatch_get_main_queue(), ^{
            for(int index = 1; index <= 20; index++){
                [weakSelf.dataList addObject:@(index)];
            }
            [weakSelf loadFinish:weakSelf.dataList bError:NO];
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *number = [_dataList objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [number stringValue];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
