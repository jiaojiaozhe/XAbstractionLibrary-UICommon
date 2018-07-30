//
//  XIBaseNotDataViewDelegate.h
//  Pods
//
//  Created by lanbiao on 2018/7/20.
//

#import <Foundation/Foundation.h>
#import "XIBaseNotDataRetryDelegate.h"

/**
 *  无数据状态接口
 */
@protocol XIBaseNotDataViewDelegate <NSObject>

/**
 *  无数据重试代理
 */
@property (nonatomic,weak) id<XIBaseNotDataRetryDelegate> retryDelegate;

/**
 *  初始化
 */
- (void) initView;

/**
 *  显示或隐藏无数据模块
 */
- (void) visibleNoData:(BOOL) bNoData;
@end
