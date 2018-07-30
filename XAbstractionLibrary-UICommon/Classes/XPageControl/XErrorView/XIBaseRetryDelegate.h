//
//  XIBaseRetryDelegate.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/23.
//

#import <Foundation/Foundation.h>

/**
 *  请求错误时的点击重试
 */
@protocol XIBaseRetryDelegate <NSObject>

/**
 *  重试操作的回调
 */
- (void) retryError;

@end
