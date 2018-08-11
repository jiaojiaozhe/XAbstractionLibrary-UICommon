//
//  BaseNotNetView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseNotNetView.h"

@interface BaseNotNetView()
@property (nonatomic,strong) IBOutlet UILabel *notNetLabel;
@property (nonatomic,strong) IBOutlet UIButton *retryBtn;
@end

@implementation BaseNotNetView

+ (id<XIBaseNotNetViewDelegate>) createNotNetView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    BaseNotNetView *notNetView = [[bundle loadNibNamed:className
                                                   owner:nil
                                                 options:nil] firstObject];
    return notNetView;
}

- (IBAction) retryClick:(id) sender{
    if(self.retryDelegate &&
       [self.retryDelegate respondsToSelector:@selector(retryNotNet:)]){
        [self.retryDelegate retryNotNet:YES];
    }
}

- (void) initView{
    //ToDO:业务实现
}

- (void) visibleNotNet:(BOOL) bNotNet{
    if(bNotNet){
        [self setHidden:NO];
        [self.notNetLabel setHidden:NO];
        [self.retryBtn setHidden:NO];
        [self.notNetLabel setText:@"无网."];
    }else{
        [self setHidden:YES];
        [self.notNetLabel setHidden:YES];
        [self.retryBtn setHidden:YES];
        [self.notNetLabel setText:@"有网络啊."];
    }
}

@end
