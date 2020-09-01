//
//  XRefreshView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/8/9.
//

#import <UIKit/UIKit.h>
#import "XBaseTableView.h"

/**
 刷新列表模板
 */
@interface XRefreshView : UIView

/**
 设置滑动控件头

 @param headView 待设置的滑动控件头
 */
- (void) setHeadView:(XBaseListHeadView *) headView;

/**
 设置滑动控件底部

 @param footView 待设置的滑动控件底部
 */
- (void) setFootView:(XBaseListFootView *) footView;

/**
 设置请滑动控件风格

 @param listStyle 待设置的滑动控件风格
 */
- (void) setListStyle:(XBaseListViewStyle) listStyle;

/**
 设置tableview的delegate

 @param delegate 待设置的delegate代理
 */
- (void) setDelegate:(id<UITableViewDelegate>) delegate;

/**
 设置tableview的datasource

 @param dataSource 待设置的datasource代理
 */
- (void) setDataSource:(id<UITableViewDelegate>) dataSource;

/**
 设置tableView的上拉下拉回调代理

 @param callBackDelegate 待设置的上拉下拉回调代理
 */
- (void) setListCallBackDelegate:(id<XListCallBackDelegate>) callBackDelegate;

/**
 加载结束回调,上拉下拉公用
 */
- (void) finishLoad;

/**
 是否自动下拉加载
 
 @param bAutoLoading YES进入页面自动加载 否则不自动加载
 */
- (void) setBAutoLoading:(BOOL) bAutoLoading;

/**
 是否支持预加载
 
 @param bPreLoadMore YES支持预加载 否则不支持预加载
 */
- (void) setBPreLoadMore:(BOOL) bPreLoadMore;
@end
