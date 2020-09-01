//
//  DemoView2.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/8/10.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "DemoView2.h"
#import "BaseLoadingView.h"
#import "BaseErrorView.h"
#import "BaseNotNetView.h"
#import "BaseNotDataView.h"
#import "CustomHeadView.h"
#import "CustomFootView.h"

@interface DemoView2()
@property (nonatomic,strong) NSMutableArray *dataList;
@end

@implementation DemoView2

- (id<XIBaseLoadingViewDelegate>) loadLoadingView{
    id<XIBaseLoadingViewDelegate> baseLoadingView = [BaseLoadingView createLoadingView];
    if(baseLoadingView){
        if([baseLoadingView respondsToSelector:@selector(initView)]){
            [baseLoadingView initView];
        }
    }
    
    return baseLoadingView;
}

- (id<XIBaseErrorViewDelegate>) loadErrorView{
    id<XIBaseErrorViewDelegate> errorView = [BaseErrorView createErrorView];
    if(errorView){
        if([errorView respondsToSelector:@selector(initView)]){
            [errorView initView];
        }
        errorView.retryDelegate = self;
    }
    return errorView;
}

- (id<XIBaseNotNetViewDelegate>) loadNotNetView{
    id<XIBaseNotNetViewDelegate> notNetView = [BaseNotNetView createNotNetView];
    if(notNetView){
        if([notNetView respondsToSelector:@selector(initView)]){
            [notNetView initView];
        }
        notNetView.retryDelegate = self;
    }
    return notNetView;
}

- (id<XIBaseNotDataViewDelegate>) loadNotDataView{
    id<XIBaseNotDataViewDelegate> notDataView = [BaseNotDataView createNotDataView];
    if(notDataView){
        if([notDataView respondsToSelector:@selector(initView)]){
            [notDataView initView];
        }
        notDataView.retryDelegate = self;
    }
    return notDataView;
}

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

- (XBaseListHeadView *) loadHeadView{
    return [CustomHeadView createHeadView];
}

- (XBaseListFootView *) loadFootView{
    return [CustomFootView createFootView];
}

- (void) refreshToDown:(UIScrollView *) scrollView{
    XLOG(@"下拉刷新");
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3.0f);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_dataList removeAllObjects];
            for(int index = 1; index <= 20; index++){
                [_dataList addObject:@(index)];
            }
            [weakSelf refreshFinish:_dataList bError:NO];
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
                [_dataList addObject:@(index)];
            }
            [weakSelf loadFinish:_dataList bError:NO];
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
