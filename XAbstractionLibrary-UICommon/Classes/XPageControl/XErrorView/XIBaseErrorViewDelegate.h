//
//  XIBaseErrorViewDelegate.h
//  Pods
//
//  Created by lanbiao on 2018/7/20.
//

#import <Foundation/Foundation.h>
#import "XIBaseRetryDelegate.h"

/**
 *  请求错误的代理
 */
@protocol XIBaseErrorViewDelegate <NSObject>

/**
 *  请求错误的代理处理对象
 */
@property (nonatomic,weak) id<XIBaseRetryDelegate> retryDelegate;

/**
 *  初始化view
 */
- (void) initView;

/**
 *  显示错误页
 *  @param bError true为错误，否则无错误
 */
- (void) visibleErrorView:(BOOL) bError;
@end
