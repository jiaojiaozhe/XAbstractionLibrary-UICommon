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

- (void)initView{
    [super initView];
    
}

- (void)loadPage{
    
}

- (XListViewStyle) getListStyle{
    return XListViewStyleStandard;
}

- (XHeadView *) loadHeadView{
    return [CustomHeadView createHeadView];
}

- (XFootView *) loadFootView{
    return [CustomFootView createFootView];
}

- (void) refreshToDown:(UIScrollView *) scrollView{
    XLOG(@"下拉刷新");
//    [self refreshFinish:@[@"",@""] bError:NO];
}

- (void) loadToMore:(UIScrollView *) scrollView{
    XLOG(@"上拉加载更多");
//    [self loadFinish:@[@"1",@"2"] bError:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
