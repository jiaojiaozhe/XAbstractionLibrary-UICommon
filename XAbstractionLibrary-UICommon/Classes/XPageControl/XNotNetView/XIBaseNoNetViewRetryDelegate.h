//
//  XIBaseNoNetViewRetryDelegate.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/23.
//

#import <Foundation/Foundation.h>

/**
 *  无网重试代理
 */
@protocol XIBaseNoNetViewRetryDelegate <NSObject>

/**
 *  无网重试代理操作
 */
- (void) retryNotNet:(BOOL) bNotNet;
@end
