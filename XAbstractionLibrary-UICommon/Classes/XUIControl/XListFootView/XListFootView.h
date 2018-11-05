//
//  XListFootView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <UIKit/UIKit.h>

@class XListFootView;
/**
 *  回调代理
 */
@protocol XListFootViewDelegate <NSObject>
/**
 *  更多回调
 *
 *  @param loadMoreView 控件对象
 */
- (void)didTriggerLoadMore:(XListFootView *)loadMoreView;

@end

/**
 *  当前更多控件所出的状态
 */
typedef NS_ENUM(NSInteger, XListFootViewState){
    /**
     *  默认
     */
    XListFootViewStateNormal,
    /**
     *  拉动
     */
    XListFootViewStatePulling,
    /**
     *  正在加载
     */
    XListFootViewStateLoadingMore
};


/**
 *  滑动控件底部控件
 */
@interface XListFootView : UIView<UIScrollViewDelegate>

/**
 *  当前更多控件状态
 */
@property (nonatomic,assign) XListFootViewState state;

/**
 *  YES 正处加载状态 NO非加载状态
 */
@property (nonatomic,assign,readonly) BOOL bLoading;

/**
 *  加载更多代理
 */
@property (nonatomic,weak) id<XListFootViewDelegate> delegate;

/**
 *  下拉过程中，到达临界点的进度，实现层实现关于它的动画
 */
- (void) pullProgress:(CGFloat) progress;

/**
 *  已经达到临界点，并且放手了，加载动画
 */
- (void) startLoading;

/**
 *  加载完成，业务层调用实现层的此方法，回收动画
 */
- (void) stopLoading;
@end
