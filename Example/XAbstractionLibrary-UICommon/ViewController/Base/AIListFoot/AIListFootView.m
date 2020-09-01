//
//  AIListFootView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIListFootView.h"

@interface AIListFootView()
@property (nonatomic,strong) IBOutlet UILabel *stateLabel;
@end

@implementation AIListFootView
@synthesize state = _state;

+ (AIListFootView *) createFootView{
    NSString *className = NSStringFromClass([self class]);
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:className
                                                   owner:self
                                                 options:nil];
    return [views firstObject];
    
    //    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    //    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

- (void) setState:(XBaseListFootViewState) state{
    if(state == XBaseListFootViewStateNormal){
        _stateLabel.text = @"上拉刷新";
        [_stateLabel sizeToFit];
    }else if(state == XBaseListFootViewStatePulling){
        _stateLabel.text = @"松开加载更多";
        [_stateLabel sizeToFit];
    }else if(state == XBaseListFootViewStateLoadingMore){
        _stateLabel.text = @"正在刷新...";
        [_stateLabel sizeToFit];
    }
    _state = state;
}

- (void) pullProgress:(CGFloat) progress{
    [super pullProgress:progress];
}

- (void) startLoading{
    [super startLoading];
}

- (void) stopLoading{
    [super stopLoading];
}

@end
