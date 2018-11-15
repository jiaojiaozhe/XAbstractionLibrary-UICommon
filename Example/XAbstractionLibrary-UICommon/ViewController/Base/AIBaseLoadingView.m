//
//  AIBaseLoadingView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/5.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIBaseLoadingView.h"

@interface AIBaseLoadingView()
@property (nonatomic,strong) IBOutlet UILabel *loadingLabel;
@end

@implementation AIBaseLoadingView

+ (id<XIBaseLoadingViewDelegate>) createLoadingView{
    NSString *className = NSStringFromClass([self class]);
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    AIBaseLoadingView *loadingView = [[bundle loadNibNamed:className
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
