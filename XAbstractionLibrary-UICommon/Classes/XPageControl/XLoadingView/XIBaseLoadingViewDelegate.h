//
//  XIBaseLoadingViewDelegate.h
//  Pods
//
//  Created by lanbiao on 2018/7/20.
//

#import <Foundation/Foundation.h>

/**
 *  加载过程中代理
 */
@protocol XIBaseLoadingViewDelegate <NSObject>

/**
 *  初始化view
 */
- (void) initView;

/**
 *  显示或隐藏进度模块
 */
- (void) visibleLoading:(BOOL) bVisible;

/**
 *  开始加载
 */
- (void) startLoad;

/**
 *  加载进度
 */
- (void) loadProgress:(long) progress totalProgress:(long) totalProgress;

/**
 *  加载成功或失败
 */
- (void) completeLoad:(BOOL) bSuccess;

@end
