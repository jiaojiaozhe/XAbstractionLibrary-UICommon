//
//  XTableView.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/16.
//

#import <UIKit/UIKit.h>
#import "XListHeadView.h"
#import "XListFootView.h"
#import "XListViewDelegate.h"

/**
 *  Created by lanbiao on 2018/07/16
 *  全面扩展XTableView,支持上拉、下拉定制、以及预加载等功能
 */
@interface XTableView : UITableView<XListViewDelegate>

/**
 *  是否正在加载，包括上拉和下拉
 */
@property (nonatomic,assign,readonly) BOOL bLoading;

/**
 *  是否进入页面自动加载
 */
@property (nonatomic,assign) BOOL bAutoLoading;

/**
 *  TableView的样式
 */
@property (nonatomic,assign) XListViewStyle  listStyle;

/**
 *  上下拉回调代理
 */
@property (nonatomic,weak) id<XListCallBackDelegate> callBackDelegate;

/**
 *  是否开启预加载
 */
@property (nonatomic,assign) BOOL bPreLoad;

/**
 设置滑动控件头部

 @param headView 待设置的控件头部
 */
- (void) setHeadView:(XListHeadView *)headView;

/**
 设置滑动控件底部

 @param footView 待设置的控件底部
 */
- (void)setFootView:(XListFootView *)footView;

/**
 *  构造新的页眉
 */
- (XListHeadView *) getListHeadView;

/**
 *  构造新的页脚
 */
- (XListFootView *) getListMoreView;

/**
 *  加载完成
 */
- (void) finishLoad;

/**
 *  刷新列表
 */
- (void) reloadData;

@end
