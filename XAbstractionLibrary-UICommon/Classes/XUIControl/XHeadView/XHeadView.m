//
//  XHeadView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import "XHeadView.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface XHeadView()
@property (nonatomic,strong) XLock *lock;
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation XHeadView
@synthesize state = _state;
@synthesize bLoading = _bLoading;

- (instancetype) init{
    if(self = [super init]){
        [self initSetUp];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initSetUp];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initSetUp];
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self initSetUp];
}

- (void) initSetUp{
    self.lock = [[XLock alloc] init];
    self.state = XHeadViewStateNormal;
}

- (void) setBLoading:(BOOL)bLoading{
    [_lock lock];
    _bLoading = bLoading;
    [_lock unlock];
}

- (BOOL) bLoading{
    BOOL bOldLoading = NO;
    [_lock lock];
    bOldLoading = _bLoading;
    [_lock unlock];
    return bOldLoading;
}

- (void) setState:(XHeadViewState)state{
    [_lock lock];
    if(state == XHeadViewStateNormal){
        
    }else if(state == XHeadViewStatePulling){
        
    }else if(state == XHeadViewStateLoading){
        
    }
    _state = state;
    [_lock unlock];
}

- (void) pullProgress:(CGFloat) progress{
}

- (void) startLoading{
    [self setBLoading:YES];
}

- (void) stopLoading{
    if(self.scrollView){
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5f animations:^{
            [weakSelf.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        } completion:^(BOOL finished) {
            weakSelf.state = XHeadViewStateNormal;
            [weakSelf setBLoading:NO];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y < -VIEW_HEIGHT(self)){
        if(self.state == XHeadViewStateNormal){
            self.state = XHeadViewStatePulling;
            [self pullProgress:1.0f];
            //兼容初次自动刷新
            [self scrollViewDidScroll:scrollView];
        }else if(self.state == XHeadViewStatePulling){
            if(!scrollView.isDragging){
                self.state = XHeadViewStateLoading;
                self.scrollView = scrollView;
                __weak typeof(self) weakSelf = self;
                [UIView animateWithDuration:0.5f animations:^{
                    weakSelf.scrollView.contentInset = UIEdgeInsetsMake(VIEW_HEIGHT(self), 0, 0, 0);
                }];
                [self startLoading];
                if([self.delegate respondsToSelector:@selector(didTriggerRefresh:)])
                    [self.delegate didTriggerRefresh:self];
            }
        }
    }else if(scrollView.contentOffset.y < 0){
        if(self.state != XHeadViewStateLoading){
            if(self.state != XHeadViewStateNormal){
                self.state = XHeadViewStateNormal;
            }
            
            CGFloat contentY = scrollView.contentOffset.y;
            CGFloat rate = contentY / -VIEW_HEIGHT(self);
            NSString *rateValue = [NSString stringWithFormat:@"%.1f",rate];
            [self pullProgress:[rateValue floatValue]];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

@end
