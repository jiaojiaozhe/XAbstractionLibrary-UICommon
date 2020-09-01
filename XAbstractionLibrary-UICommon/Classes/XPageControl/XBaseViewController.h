//
//  XBaseViewController.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/20.
//

#import "XBaseView.h"
#import "XHeadViewDelegate.h"
#import <UIKit/UIKit.h>
#import <XAbstractionLibrary_NetWork/XAbstractionLibrary-NetWork-umbrella.h>

/**
 基础的试图控制器，自身不支持滑动，但天然支持无网、加载过程、加载失败、无数据等的支持
 */
@interface XBaseViewController : UIViewController<XHttpResponseDelegate,XHeadViewDelegate>

/**
 加载内容区，原则上不能为nil，需要业务工程师实现

 @return 返回内容区
 */
- (XBaseView *) loadViewPresenter;

/**
 *  设置底部线条是否显示，默认YES
 */
- (void) setShowLine:(BOOL) bShow;

/**
 *  设置底部线条颜色
 */
- (void) setLineColor:(UIColor *) color;

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
