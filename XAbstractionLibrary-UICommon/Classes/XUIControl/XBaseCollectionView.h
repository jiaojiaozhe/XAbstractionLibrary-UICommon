//
//  XBaseCollectionView.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/20.
//

#import <UIKit/UIKit.h>
#import "XBaseListHeadView.h"
#import "XBaseListFootView.h"
#import "XListViewDelegate.h"

/**
 *  Created by lanbiao on 2018/07/20
 *  全面扩展XTableView,支持上拉、下拉定制、以及预加载等功能
 */
@interface XBaseCollectionView : UICollectionView

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
 *  刷新列表
 */
- (void) reloadData;

@end
