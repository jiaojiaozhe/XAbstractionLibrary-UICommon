//
//  XListViewDelegate.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <Foundation/Foundation.h>

#import "XListViewMacro.h"

/**
 *  滚动控件新特性
 */
@protocol XListViewDelegate <NSObject>

@optional

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
 *  预加载率,默认为2，表明当滚动到距离下边缘小于2倍tableView的时候开始预加载
 */
- (CGFloat) getPerLoadRate;

/**
 *  加载超时时长
 */
- (CGFloat) getLoadTimeOut;


/**
 *  刷新或加载更多结束
 */
- (void) finishLoad;

/**
 *  刷新列表
 */
- (void) reloadData;

@required
/**
 *  构造新的页眉
 */
- (XBaseListHeadView *) getListHeadView;

/**
 *  构造新的页脚
 */
- (XBaseListFootView *) getListMoreView;


@end
