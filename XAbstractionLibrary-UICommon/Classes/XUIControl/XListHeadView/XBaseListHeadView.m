//
//  XBaseListHeadView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import "XBaseListHeadView.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface XBaseListHeadView()
@property (nonatomic,strong) XLock *lock;
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation XBaseListHeadView
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
    self.state = XBaseListHeadViewStateNormal;
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

- (void) setState:(XBaseListHeadViewState)state{
    [_lock lock];
    if(state == XBaseListHeadViewStateNormal){
        
    }else if(state == XBaseListHeadViewStatePulling){
        
    }else if(state == XBaseListHeadViewStateLoading){
        
    }
    _state = state;
    [_lock unlock];
}

- (void) pullProgress:(CGFloat) progress{
    NSLog(@"%f",progress);
}

- (void) startLoading{
    [self setBLoading:YES];
    NSLog(@"startLoading");
}

- (void) stopLoading{
    if(self.scrollView){
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5f animations:^{
            [weakSelf.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        } completion:^(BOOL finished) {
            weakSelf.state = XBaseListHeadViewStateNormal;
            [weakSelf setBLoading:NO];
        }];
    }
}

- (void) stopAutoLoading{
    if(self.scrollView){
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5f animations:^{
            [weakSelf.scrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        } completion:^(BOOL finished) {
            weakSelf.state = XBaseListHeadViewStateNormal;
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y < -VIEW_HEIGHT(self)){
        if(self.state == XBaseListHeadViewStateNormal){
            self.state = XBaseListHeadViewStatePulling;
            [self pullProgress:1.0f];
            //兼容初次自动刷新
            [self scrollViewDidEndDragging:scrollView willDecelerate:YES];
        }
    }else if(scrollView.contentOffset.y < 0){
    
        if(self.state != XBaseListHeadViewStateLoading){
            if(self.state != XBaseListHeadViewStateNormal){
                self.state = XBaseListHeadViewStateNormal;
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
    if(scrollView.contentOffset.y < -VIEW_HEIGHT(self)){
        if(self.state == XBaseListHeadViewStatePulling){
            if(!scrollView.isDragging){
                self.state = XBaseListHeadViewStateLoading;
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
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

@end
