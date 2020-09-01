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
typedef NS_ENUM(NSInteger, XBaseListViewStyle){
    
    /**
     *  默认，没有页眉页脚
     */
    XBaseListViewStyleNone,
    
    /**
     *  标准 有页眉也有页脚
     */
    XBaseListViewStyleStandard,
    
    /**
     *  只有页眉
     */
    XBaseListViewStyleHeader,
    
    /**
     *  只有页脚
     */
    XBaseListViewStyleFooter
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
