//
//  BaseNotDataView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseNotDataView.h"

@interface BaseNotDataView()
@property (nonatomic,strong) IBOutlet UILabel *notDataTipLabel;
@property (nonatomic,strong) IBOutlet UIButton *retryBtn;
@end

@implementation BaseNotDataView

+ (id<XIBaseNotDataViewDelegate>) createNotDataView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    BaseNotDataView *notDataView = [[bundle loadNibNamed:className
                                                 owner:nil
                                               options:nil] firstObject];
    return notDataView;
}

- (void) initView{
    //ToDo:业务实现
}


- (void) visibleNoData:(BOOL) bNoData{
    if(bNoData){
        [self setHidden:NO];
        [self.notDataTipLabel setHidden:NO];
        [self.retryBtn setHidden:NO];
        [self.notDataTipLabel setText:@"无数据耶."];
    }else{
        [self setHidden:YES];
        [self.notDataTipLabel setHidden:YES];
        [self.retryBtn setHidden:YES];
        [self.notDataTipLabel setText:@"明明有数据啊."];
    }
}

@end
