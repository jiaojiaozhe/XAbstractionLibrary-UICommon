//
//  BaseTableView.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/16.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <XAbstractionLibrary_UICommon/XAbstractionLibrary-UICommon-umbrella.h>

@interface BaseTableView : XTableView

/**
 *  自定义的页眉
 */
- (XHeadView *) getListHeadView;


/**
 *  自定义的页脚
 */
- (XFootView *) getListMoreView;

@end
