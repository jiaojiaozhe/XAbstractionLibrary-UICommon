//
//  XRefreshView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/8/9.
//

#import <UIKit/UIKit.h>
#import "XTableView.h"

/**
 刷新列表模板
 */
@interface XRefreshView : UIView

/**
 设置滑动控件头

 @param headView 待设置的滑动控件头
 */
- (void) setHeadView:(XHeadView *) headView;

/**
 设置滑动控件底部

 @param footView 待设置的滑动控件底部
 */
- (void) setFootView:(XFootView *) footView;

/**
 设置请滑动控件风格

 @param listStyle 待设置的滑动控件风格
 */
- (void) setListStyle:(XListViewStyle) listStyle;

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
@end
