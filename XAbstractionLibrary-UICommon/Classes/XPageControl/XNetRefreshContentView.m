//
//  XNetRefreshContentView.m
//  Pods
//
//  Created by lanbiao on 2018/8/10.
//

#import "XNetRefreshContentView.h"

@implementation XNetRefreshContentView

- (void) loadMore{
    
}

- (void) listViewDidTriggerRefresh:(UIScrollView *) listView{
    [self loadPage];
}

- (void) listViewDidTriggerLoadMore:(UIScrollView *) listView{
    [self loadMore];
}

@end
