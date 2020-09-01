//
//  BaseTableView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/16.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseTableView.h"
#import "CustomHeadView.h"
#import "CustomFootView.h"

@implementation BaseTableView

- (XBaseListHeadView *) getListHeadView{
    return [CustomHeadView createHeadView];
}

- (XBaseListFootView *) getListMoreView{
    return [CustomFootView createFootView];
}

@end
