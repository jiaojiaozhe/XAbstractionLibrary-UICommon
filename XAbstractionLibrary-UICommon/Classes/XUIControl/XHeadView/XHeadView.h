//
//  XHeadView.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <UIKit/UIKit.h>

/**
 *  当前下拉控件所出的状态
 */
typedef NS_ENUM(NSInteger, XHeadViewState){
    /**
     *  默认
     */
    XHeadViewStateNormal,
    /**
     *  拉动
     */
    XHeadViewStatePulling,
    /**
     *  正在加载
     */
    XHeadViewStateLoading
};

@class XHeadView;
@protocol XHeadViewDelegate <NSObject>
@optional
- (void)didTriggerRefresh:(XHeadView *) refreshView;
@end

/**
 *  滑动控件头
 */
@interface XHeadView : UIView<UIScrollViewDelegate>

/**
 *  是否正在加载过程中
 */
@property (nonatomic,assign,readonly) BOOL bLoading;

/**
 *  下拉控件状态
 */
@property (nonatomic,assign) XHeadViewState state;

/**
 *  回调代理
 */
@property (nonatomic,weak) id<XHeadViewDelegate> delegate;

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
