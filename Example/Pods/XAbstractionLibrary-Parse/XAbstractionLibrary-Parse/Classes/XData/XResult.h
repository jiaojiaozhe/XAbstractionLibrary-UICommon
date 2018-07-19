//
//  XResult.h
//  XAbstractionLibrary-Parse
//
//  Created by lanbiao on 2018/7/13.
//

#import <Foundation/Foundation.h>

/**
 *  接口返回接口
 */
@protocol XResult <NSObject>

/**
 *  成功
 */
- (BOOL) isSuccess;

/**
 *  获取服务端返回提示语
 */
- (NSString*) getServerMsg;

@end
