//
//  XAbstractView.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/20.
//

#import <Foundation/Foundation.h>
#import "XIBaseLoadingViewDelegate.h"
#import "XIBaseErrorViewDelegate.h"
#import "XIBaseNotDataViewDelegate.h"
#import "XIBaseNotNetViewDelegate.h"

/**
 *  created by lanbiao on 2018/07/20
 *  抽象化接口，需要业务实现
 */
@protocol XAbstractView <NSObject>

/**
 *  获取内容区的view
 */
- (UIView *) getContentView;

/**
 *  设定加载状态页
 */
- (id<XIBaseLoadingViewDelegate>) loadLoadingView;

/**
 *  设定加载错误页
 */
- (id<XIBaseErrorViewDelegate>) loadErrorView;

/**
 *  设定无网加载页
 */
- (id<XIBaseNotNetViewDelegate>) loadNotNetView;

/**
 *  设定无数据加载页
 */
- (id<XIBaseNotDataViewDelegate>) loadNotDataView;

/**
 *  初始化view
 */
- (void) initView;

/**
 *  页面初始化后，第一次的业务逻辑
 */
- (void) loadPage;

/**
 *  页面初始化数据
 */
- (void) initData;
@end
