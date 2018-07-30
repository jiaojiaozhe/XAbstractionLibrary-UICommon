//
//  XIBaseNotNetViewDelegate.h
//  Pods
//
//  Created by lanbiao on 2018/7/20.
//

#import <Foundation/Foundation.h>
#import "XIBaseNoNetViewRetryDelegate.h"

/**
 *  无网状态接口
 */
@protocol XIBaseNotNetViewDelegate <NSObject>

/**
 *  重试代理
 */
@property (nonatomic,weak) id<XIBaseNoNetViewRetryDelegate> retryDelegate;

/**
 *  初始化
 */
- (void) initView;

/**
 *  显示或隐藏无网模块
 */
- (void) visibleNotNet:(BOOL) bNotNet;
@end
