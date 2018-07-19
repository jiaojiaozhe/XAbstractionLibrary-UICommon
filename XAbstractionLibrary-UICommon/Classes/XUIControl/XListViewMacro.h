//
//  XListViewMacro.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#ifndef XListViewMacro_h
#define XListViewMacro_h

/**
 *  控件样式
 */
typedef NS_ENUM(NSInteger, XListViewStyle){
    
    /**
     *  默认，没有页眉页脚
     */
    XListViewStyleNone,
    
    /**
     *  标准 有页眉也有页脚
     */
    XListViewStyleStandard,
    
    /**
     *  只有页眉
     */
    XListViewStyleHeader,
    
    /**
     *  只有页脚
     */
    XListViewStyleFooter
};

/**
 *  上下啦刷新回调
 */
@protocol XListCallBackDelegate <NSObject>
@optional
- (void) listViewDidTriggerRefresh:(UIScrollView *) listView;
- (void) listViewDidTriggerLoadMore:(UIScrollView *) listView;
@end

#endif /* XListViewMacro_h */
