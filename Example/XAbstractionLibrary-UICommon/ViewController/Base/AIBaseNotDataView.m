//
//  AIBaseNotDataView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseNotDataView.h"

@interface AIBaseNotDataView()
@property (nonatomic,strong) IBOutlet UILabel *notDataTipLabel;
@property (nonatomic,strong) IBOutlet UIButton *retryBtn;
@end

@implementation AIBaseNotDataView

+ (id<XIBaseNotDataViewDelegate>) createNotDataView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    AIBaseNotDataView *notDataView = [[bundle loadNibNamed:className
                                                     owner:nil
                                                   options:nil] firstObject];
    return notDataView;
}

- (IBAction) retryClick:(id) sender{
    if(self.retryDelegate &&
       [self.retryDelegate respondsToSelector:@selector(retryNotData)]){
        [self.retryDelegate retryNotData];
    }
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
