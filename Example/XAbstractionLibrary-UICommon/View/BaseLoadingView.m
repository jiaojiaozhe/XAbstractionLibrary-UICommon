//
//  BaseLoadingView.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/23.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "BaseLoadingView.h"

@interface BaseLoadingView()
@property (nonatomic,strong) IBOutlet UILabel *loadingLabel;
@end

@implementation BaseLoadingView

+ (id<XIBaseLoadingViewDelegate>) createLoadingView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    BaseLoadingView *loadingView = [[bundle loadNibNamed:className
                                                   owner:nil
                                                 options:nil] firstObject];
    return loadingView;
}

- (void) initView{
    //TODO：业务实现
}

- (void) visibleLoading:(BOOL) bVisible{
    if(bVisible){
        [self setHidden:NO];
        [self.loadingLabel setHidden:NO];
    }else{
        [self setHidden:YES];
        [self.loadingLabel setHidden:YES];
    }
}

- (void) startLoad{
//    [self setHidden:NO];
//    [self.loadingLabel setHidden:NO];
    [self.loadingLabel setText:@"readly loading."];
}

- (void) loadProgress:(long) progress totalProgress:(long) totalProgress{
//    [self setHidden:NO];
//    [self.loadingLabel setHidden:NO];
    [self.loadingLabel setText:@"loading..."];
}

- (void) completeLoad:(BOOL) bSuccess{
//    [self setHidden:YES];
//    [self.loadingLabel setHidden:YES];
    if(bSuccess){
        [self.loadingLabel setText:@"complete."];
    }else{
        [self.loadingLabel setText:@"fail."];
    }
}

@end
