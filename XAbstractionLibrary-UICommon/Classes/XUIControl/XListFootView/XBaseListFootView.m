//
//  XBaseListFootView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import "XBaseListFootView.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface XBaseListFootView()<UIScrollViewDelegate>
@property (nonatomic,strong) XLock *lock;
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation XBaseListFootView
@synthesize state = _state;
@synthesize bLoading = _bLoading;

- (instancetype) init{
    if(self = [super init]){
        [self initSetup];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initSetup];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initSetup];
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self initSetup];
}

- (void) initSetup{
    self.lock = [[XLock alloc] init];
    self.state = XBaseListFootViewStateNormal;
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

- (void) setState:(XBaseListFootViewState) state{
    [_lock lock];
    if(state == XBaseListFootViewStateNormal){
        
    }else if(state == XBaseListFootViewStatePulling){
        
    }else if(state == XBaseListFootViewStateLoadingMore){
        
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
            weakSelf.state = XBaseListFootViewStateNormal;
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
            weakSelf.state = XBaseListFootViewStateNormal;
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat criticalValueY = scrollView.contentSize.height;
    
    if(scrollView.frame.size.height >= scrollView.contentSize.height){
        if(contentOffsetY > VIEW_HEIGHT(self)){
            //松手加载更多
            if(self.state == XBaseListFootViewStateNormal){
                self.state = XBaseListFootViewStatePulling;
                [self pullProgress:1.0f];
            }
        }else if(contentOffsetY > 0){
            //上拉加载更多
            if(self.state != XBaseListFootViewStateLoadingMore){
                if(self.state != XBaseListFootViewStateNormal){
                    self.state = XBaseListFootViewStateNormal;
                }
            }
            
            CGFloat offsetY = contentOffsetY + VIEW_HEIGHT(scrollView) - criticalValueY;
            CGFloat rate = offsetY / VIEW_HEIGHT(self);
            NSString *rateValue = [NSString stringWithFormat:@"%.1f",rate];
            [self pullProgress:[rateValue floatValue]];
        }else{
            //正常情况
        }
    }else{
        if(contentOffsetY + VIEW_HEIGHT(scrollView) > criticalValueY + VIEW_HEIGHT(self)){
            //松手加载
            if(self.state == XBaseListFootViewStateNormal){
                self.state = XBaseListFootViewStatePulling;
                [self pullProgress:1.0f];
            }
        }else if(contentOffsetY + VIEW_HEIGHT(scrollView) > criticalValueY){
            //上拉加载更多
            if(self.state != XBaseListFootViewStateLoadingMore){
                if(self.state != XBaseListFootViewStateNormal){
                    self.state = XBaseListFootViewStateNormal;
                }
            }
            
            CGFloat offsetY = contentOffsetY + VIEW_HEIGHT(scrollView) - criticalValueY;
            CGFloat rate = offsetY / VIEW_HEIGHT(self);
            NSString *rateValue = [NSString stringWithFormat:@"%.1f",rate];
            [self pullProgress:[rateValue floatValue]];
        }else{
            //正常状况
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(scrollView.frame.size.height >= scrollView.contentSize.height){
        if(self.state == XBaseListFootViewStatePulling){
            if(!scrollView.isDragging){
                self.state = XBaseListFootViewStateLoadingMore;
                self.scrollView = scrollView;
                __weak typeof(self) weakSelf = self;
                [UIView animateWithDuration:0.5f
                                 animations:^{
                                     scrollView.contentInset = UIEdgeInsetsMake(0, 0, VIEW_HEIGHT(scrollView) - scrollView.contentSize.height + VIEW_HEIGHT(weakSelf), 0);
                                 }];
                [self startLoading];
                if([self.delegate respondsToSelector:@selector(didTriggerLoadMore:)])
                    [self.delegate didTriggerLoadMore:self];
            }
        }
    }else{
        if(self.state == XBaseListFootViewStatePulling){
            if(!scrollView.isDragging){
                self.state = XBaseListFootViewStateLoadingMore;
                self.scrollView = scrollView;
                [UIView animateWithDuration:0.5f
                                 animations:^{
                                     scrollView.contentInset = UIEdgeInsetsMake(0, 0, VIEW_HEIGHT(self), 0);
                                 }];
                [self startLoading];
                if([self.delegate respondsToSelector:@selector(didTriggerLoadMore:)])
                    [self.delegate didTriggerLoadMore:self];
            }
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}

@end
