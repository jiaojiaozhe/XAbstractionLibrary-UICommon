//
//  AIListHeadView.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/11.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIListHeadView.h"

@interface AIListHeadView()
@property (nonatomic,strong) IBOutlet UILabel *stateLabel;
@end

@implementation AIListHeadView
@synthesize state = _state;

+ (AIListHeadView *) createHeadView{
    NSString *className = NSStringFromClass([self class]);
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:className
                                                   owner:self
                                                 options:nil];
    return [views firstObject];
    
    //    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    //    return [nib instantiateWithOwner:nil options:nil].firstObject;
}

- (void) setState:(XBaseListHeadViewState)state{
    if(state == XBaseListHeadViewStateNormal){
        _stateLabel.text = @"下拉刷新";
        [_stateLabel sizeToFit];
    }else if(state == XBaseListHeadViewStatePulling){
        _stateLabel.text = @"松开即可刷新";
        [_stateLabel sizeToFit];
    }else if(state == XBaseListHeadViewStateLoading){
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
