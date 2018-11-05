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

- (XListHeadView *) getListHeadView{
    return [CustomHeadView createHeadView];
}

- (XListFootView *) getListMoreView{
    return [CustomFootView createFootView];
}

@end
