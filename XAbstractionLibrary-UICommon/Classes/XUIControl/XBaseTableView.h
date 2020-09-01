//
//  XBaseTableView.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/16.
//

#import <UIKit/UIKit.h>
#import "XBaseListHeadView.h"
#import "XBaseListFootView.h"
#import "XListViewDelegate.h"

/**
 *  Created by lanbiao on 2018/07/16
 *  全面扩展XBaseTableView,支持上拉、下拉定制、以及预加载等功能
 */
@interface XBaseTableView : UITableView<XListViewDelegate>

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
@property (nonatomic,assign) XBaseListViewStyle  listStyle;

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
- (void) setHeadView:(XBaseListHeadView *)headView;

/**
 设置滑动控件底部

 @param footView 待设置的控件底部
 */
- (void)setFootView:(XBaseListFootView *)footView;

/**
 *  构造新的页眉
 */
- (XBaseListHeadView *) getListHeadView;

/**
 *  构造新的页脚
 */
- (XBaseListFootView *) getListMoreView;

/**
 *  加载完成
 */
- (void) finishLoad;

/**
 *  加载未完成，但等待时间到了，归位UI
 */
- (void) finishAutoLoad;

/**
 *  刷新列表
 */
- (void) reloadData;

@end
