//
//  XBaseView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <UIKit/UIKit.h>
#import "XAbstractView.h"
#import <XAbstractionLibrary_NetWork/XAbstractionLibrary-NetWork-umbrella.h>

/**
*   created by lanbiao on 2018/07/20
 *  抽象化view,包含错误、无网、空数据、加载中等的异常处理
 */
@interface XBaseView : UIView<XAbstractView,XHttpResponseDelegate,XIBaseNoNetViewRetryDelegate,XIBaseRetryDelegate,XIBaseNotDataRetryDelegate>


/**
 *  获得模板XBaseView
 */
+ (instancetype) createView;

/**
 *  获取内容区
 */
- (UIView *) getContentView;

/**
 刷新页面各状态
 */
- (void) refreshStatusView;

/**
 设置请求错误状态

 @param bError 待设置的状态
 */
- (void) setBError:(BOOL)bError;

/**
 设置请求无网状态

 @param bNotNet 待设置的无网状态
 */
- (void) setBNotNet:(BOOL)bNotNet;

/**
 设置加载状态

 @param bLoading 待设置的加载状态
 */
- (void) setBLoading:(BOOL)bLoading;

/**
 设置无数据状态

 @param bNotData 待设置的无数据状态
 */
- (void) setBNotData:(BOOL)bNotData;

/**
 设置是否最终忽略上述各状态，一般用于成功加载后

 @param bIgnoreShowError 待设置忽略状态
 */
- (void) setBIgnoreShowError:(BOOL)bIgnoreShowError;

/**
 发送UI全局广播
 
 @param action 广播标识
 @param dataInfo 该广播对应的数据
 */
- (void) onSendMyBroadcast:(XNotification_Action) action dataInfo:(id) dataInfo;

/**
 全局消息处理方法
 
 @param notification 接收到待处理的消息
 */
- (void) onMyBroadcastReceiver:(NSNotification *) notification;
@end
