//
//  BaseView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseView.h"
#import "BaseLoadingView.h"
#import "BaseErrorView.h"
#import "BaseNotNetView.h"
#import "BaseNotDataView.h"

@implementation BaseView

- (id<XIBaseLoadingViewDelegate>) loadLoadingView{
    id<XIBaseLoadingViewDelegate> baseLoadingView = [BaseLoadingView createLoadingView];
    if(baseLoadingView && [baseLoadingView respondsToSelector:@selector(initView)]){
        [baseLoadingView initView];
    }
    return baseLoadingView;
}

- (id<XIBaseErrorViewDelegate>) loadErrorView{
    id<XIBaseErrorViewDelegate> errorView = [BaseErrorView createErrorView];
    if(errorView && [errorView respondsToSelector:@selector(initView)]){
        [errorView initView];
    }
    return errorView;
}

- (id<XIBaseNotNetViewDelegate>) loadNotNetView{
    id<XIBaseNotNetViewDelegate> notNetView = [BaseNotNetView createNotNetView];
    if(notNetView && [notNetView respondsToSelector:@selector(initView)]){
        [notNetView initView];
    }
    return notNetView;
}

- (id<XIBaseNotDataViewDelegate>) loadNotDataView{
    id<XIBaseNotDataViewDelegate> notDataView = [BaseNotDataView createNotDataView];
    if(notDataView && [notDataView respondsToSelector:@selector(initView)]){
        [notDataView initView];
    }
    return notDataView;
}

@end
