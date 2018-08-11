//
//  BaseErrorView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseErrorView.h"

@interface BaseErrorView()
@property (nonatomic,strong) IBOutlet UILabel *errorTipLabel;
@property (nonatomic,strong) IBOutlet UIButton *retryBtn;
@end

@implementation BaseErrorView

+ (id<XIBaseErrorViewDelegate>) createErrorView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    BaseErrorView *errorView = [[bundle loadNibNamed:className
                                                   owner:nil
                                                 options:nil] firstObject];
    return errorView;
}

- (IBAction) retryClick:(id) sender{
    if(self.retryDelegate &&
       [self.retryDelegate respondsToSelector:@selector(retryError)]){
        [self.retryDelegate retryError];
    }
}

- (void) initView{
    //ToDo:业务实现
}

- (void) visibleErrorView:(BOOL) bError{
    if(!bError){
        [self setHidden:YES];
        [self.errorTipLabel setHidden:YES];
        [self.retryBtn setHidden:YES];
        [self.errorTipLabel setText:@"请求成功."];
    }else{
        [self setHidden:NO];
        [self.errorTipLabel setHidden:NO];
        [self.retryBtn setHidden:NO];
        [self.errorTipLabel setText:@"请求出错"];
    }
}

@end
