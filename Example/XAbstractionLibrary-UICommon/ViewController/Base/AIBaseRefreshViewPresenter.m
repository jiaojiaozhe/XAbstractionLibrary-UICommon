//
//  AIBaseRefreshContentView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIListHeadView.h"
#import "AIListFootView.h"
#import "AIBaseErrorView.h"
#import "AIBaseNotNetView.h"
#import "AIBaseLoadingView.h"
#import "AIBaseNotDataView.h"
#import "AIBaseRefreshViewPresenter.h"

@implementation AIBaseRefreshViewPresenter

- (instancetype)init{
    self = [super init];
    if (self) {
        //[self awakeFromNib];
    }
    return self;
}

- (id<XIBaseLoadingViewDelegate>)loadLoadingView{
    id<XIBaseLoadingViewDelegate> loadingView = [AIBaseLoadingView createLoadingView];
    if(loadingView &&
       [loadingView respondsToSelector:@selector(initView)]){
        [loadingView initView];
    }
    return loadingView;
}

- (id<XIBaseNotNetViewDelegate>)loadNotNetView{
    id<XIBaseNotNetViewDelegate> notNetView = [AIBaseNotNetView createNotNetView];
    if(notNetView &&
       [notNetView respondsToSelector:@selector(initView)]){
        [notNetView initView];
    }
    return notNetView;
}

- (id<XIBaseErrorViewDelegate>)loadErrorView{
    id<XIBaseErrorViewDelegate> errorView = [AIBaseErrorView createErrorView];
    if(errorView &&
       [errorView respondsToSelector:@selector(initView)]){
        [errorView initView];
    }
    return errorView;
}

- (id<XIBaseNotDataViewDelegate>)loadNotDataView{
    id<XIBaseNotDataViewDelegate> notDataView = [AIBaseNotDataView createNotDataView];
    if(notDataView &&
       [notDataView respondsToSelector:@selector(initView)]){
        [notDataView initView];
    }
    return notDataView;
}

- (void)initView{
    [super initView];
    
}

- (void)loadPage{
    
}

- (XListHeadView *) loadHeadView{
    return [AIListHeadView createHeadView];
}

- (XListFootView *) loadFootView{
    return [AIListFootView createFootView];
}

- (XListViewStyle) getListStyle{
    return XListViewStyleStandard;
}

- (void) refreshToDown:(UIScrollView *) scrollView{
    XLOG(@"下拉刷新");
    //    [self refreshFinish:@[@"",@""] bError:NO];
}

- (void) loadToMore:(UIScrollView *) scrollView{
    XLOG(@"上拉加载更多");
    //    [self loadFinish:@[@"1",@"2"] bError:YES];
}

@end
