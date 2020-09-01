//
//  AITableView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AITableView.h"
#import "AIListHeadView.h"
#import "AIListFootView.h"

@implementation AITableView

- (XBaseListHeadView *) getListHeadView{
    return [AIListHeadView createHeadView];
}

- (XBaseListFootView *)getListMoreView{
    return [AIListFootView createFootView];
}
@end
