//
//  XListHeadView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import "XListHeadView.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface XListHeadView()
@property (nonatomic,strong) XLock *lock;
@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation XListHeadView
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
    self.state = XListHeadViewStateNormal;
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

- (void) setState:(XListHeadViewState)state{
    [_lock lock];
    if(state == XListHeadViewStateNormal){
        
    }else if(state == XListHeadViewStatePulling){
        
    }else if(state == XListHeadViewStateLoading){
        
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
            weakSelf.state = XListHeadViewStateNormal;
            [weakSelf setBLoading:NO];
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y < -VIEW_HEIGHT(self)){
        if(self.state == XListHeadViewStateNormal){
            self.state = XListHeadViewStatePulling;
            [self pullProgress:1.0f];
            //兼容初次自动刷新
            [self scrollViewDidEndDragging:scrollView willDecelerate:YES];
        }
    }else if(scrollView.contentOffset.y < 0){
    
        if(self.state != XListHeadViewStateLoading){
            if(self.state != XListHeadViewStateNormal){
                self.state = XListHeadViewStateNormal;
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
        if(self.state == XListHeadViewStatePulling){
            if(!scrollView.isDragging){
                self.state = XListHeadViewStateLoading;
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
