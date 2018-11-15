//
//  AICollectionView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIListHeadView.h"
#import "AIListFootView.h"
#import "AICollectionView.h"

@implementation AICollectionView

- (XListHeadView *)getListHeadView{
    return [AIListHeadView createHeadView];
}

- (XListFootView *)getListMoreView{
    return [AIListFootView createFootView];
}
@end
