//
//  XRefreshContentView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/8/9.
//

#import "XView.h"
#import "XTableView.h"

/**
 刷新列表布局类，主要提高开发效率
 */
@interface XRefreshContentView : XView<UITableViewDelegate,UITableViewDataSource>

/**
 下拉刷新回调,需要业务实现，回调结束需要调用refreshFinish:bError:

 @param scrollView 当前下拉关联的滑动控件
 */
- (void) refreshToDown:(UIScrollView *) scrollView;

/**
 刷新完成的回调
 
 @param dataList 刷新到的数据集合
 @param bError 是否存在错误
 */
- (void) refreshFinish:(NSArray *) dataList bError:(BOOL) bError;

/**
 上拉刷新回调,需要业务实现，回调结束需要调用loadFinish:bError:

 @param scrollView 当前上拉关联的滑动控件
 */
- (void) loadToMore:(UIScrollView *) scrollView;

/**
 加载完成的回调

 @param dataList 加载完成的数据源
 @param bError 是否存在错误
 */
- (void) loadFinish:(NSArray *) dataList bError:(BOOL) bError;
@end
