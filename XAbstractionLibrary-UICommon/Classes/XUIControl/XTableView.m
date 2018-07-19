//
//  XTableView.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/16.
//

#import "XTableView.h"
#import "XMessageInterceptor.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

/**
 *  预加载默认距离，多少个tableView的高度
 */
#define         PER_LOADRATE            2.0f

/**
 *  默认的加载超时时长
 */
#define         LOAD_TIMEOUT            3.f

/**
 *  时间采样间隔
 */
#define         SAMPLING_RATE           0.1f

@interface XTableView()<XHeadViewDelegate,XFootViewDelegate>

@property (nonatomic,strong) XLock *lock;

/**
 *  头部控件
 */
@property (nonatomic,strong) XHeadView *headView;

/**
 *  底部控件
 */
@property (nonatomic,strong) XFootView *footView;

/**
 *  消息转发器
 */
@property (nonatomic,strong) XMessageInterceptor *messageInterceotor;

/**
 *  上一次滑动的位置
 */
@property (nonatomic,assign) CGFloat lastY;

/**
 *  上一次采集lastY的时戳
 */
@property (nonatomic,assign) CFAbsoluteTime lastTimeInterval;

/**
 *  处理底部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *topConstraint;


@end

@implementation XTableView
@synthesize bLoading = _bLoading;
@synthesize bAutoLoading = _bAutoLoading;

- (instancetype) init{
    if(self = [super init]){
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

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        [self initSetUp];
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self initSetUp];
}

- (void) setBAutoLoading:(BOOL)bAutoLoading{
    [_lock lock];
    _bAutoLoading = bAutoLoading;
    [_lock unlock];
}

- (BOOL) bAutoLoading{
    [_lock lock];
    BOOL bAutoLoading = _bAutoLoading;
    [_lock unlock];
    return bAutoLoading;
}

- (BOOL) bLoading{
    [_lock lock];
    BOOL bLoading = NO;
    if(_headView){
        bLoading = [_headView bLoading];
    }
    
    if(!bLoading){
        if(_footView){
            bLoading = [_footView bLoading];
        }
    }
    [_lock unlock];
    return bLoading;
}


- (void) initSetUp{
    _lock = [[XLock alloc] init];
    self.listStyle = XListViewStyleNone;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1.0f);
        if([weakSelf bPullToDown]){
            if(weakSelf.bAutoLoading){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf setContentOffset:CGPointMake(0, -VIEW_HEIGHT(weakSelf.headView) - 50)];
                });
            }
        }
    });
    
}

- (XMessageInterceptor* ) messageInterceotor{
    if(_messageInterceotor == NULL){
        _messageInterceotor = [[XMessageInterceptor alloc] init];
        _messageInterceotor.interceptor = self;
        _messageInterceotor.delegateReceiver = super.delegate;
        _messageInterceotor.dataSourceReceiver = super.dataSource;
    }
    return _messageInterceotor;
}

- (void) setDelegate:(id<UITableViewDelegate>)delegate{
    if(self.messageInterceotor){
        self.messageInterceotor.delegateReceiver = delegate;
        if(delegate){
            super.delegate = (id<UITableViewDelegate>)self.messageInterceotor;
        }else{
            super.delegate = nil;
        }
    }else{
        super.delegate = delegate;
    }
}

//- (id<UITableViewDelegate>) delegate{
//    if(self.messageInterceotor){
//        return (id<UITableViewDelegate>) self.messageInterceotor;
//    }else{
//        return nil;
//    }
//}

- (void) setDataSource:(id<UITableViewDataSource>)dataSource{
    if(self.messageInterceotor){
        self.messageInterceotor.dataSourceReceiver = dataSource;
        if(dataSource){
            super.dataSource = (id<UITableViewDataSource>)self.messageInterceotor;
        }else{
            super.dataSource = nil;
        }
    }else{
        super.dataSource = dataSource;
    }
}

//- (id<UITableViewDataSource>) dataSource{
//    if(self.messageInterceotor){
//        return (id<UITableViewDataSource>)self.messageInterceotor;
//    }else{
//        return nil;
//    }
//}

- (void) setListStyle:(XListViewStyle)listStyle{
    _listStyle = listStyle;
    
    if(_listStyle == XListViewStyleStandard){
        [self removeRefreshView];
        [self removeFootView];
        [self loadRefreshView];
        [self loadFootView];
    }
    else if(_listStyle == XListViewStyleHeader){
        [self removeRefreshView];
        [self removeFootView];
        [self loadRefreshView];
    }
    else if(_listStyle == XListViewStyleFooter){
        [self removeRefreshView];
        [self removeFootView];
        [self loadFootView];
    }
    else{
        [self removeRefreshView];
        [self removeFootView];
    }
}

- (void) loadRefreshView{
    if(!_headView){
        _headView = [self getListHeadView];
        _headView.delegate = self;
        CGFloat height = VIEW_HEIGHT(_headView);
        if(self.constraints.count > 0 || !self.translatesAutoresizingMaskIntoConstraints){
            _headView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_headView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:-(height)];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_headView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_headView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0f
                                                                                 constant:height];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_headView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1.0f
                                                                                constant:0.0];
            [self addSubview:_headView];
            [self addConstraint:topConstraint];
            [self addConstraint:leftConstraint];
            [self addConstraint:heightConstraint];
            [self addConstraint:widthConstraint];
            [_headView setNeedsLayout];
            [_headView layoutIfNeeded];
        }else{
            [self addSubview:_headView];
            SET_VIEW_TOP(_headView, -(VIEW_HEIGHT(_headView)));
            SET_VIEW_LEFT(_headView, 0);
            SET_VIEW_WIDTH(_headView, VIEW_WIDTH(self));
            SET_VIEW_HEIGHT(_headView, VIEW_HEIGHT(_headView));
        }
    }
}

- (void) removeRefreshView{
    if(_headView){
        [_headView removeFromSuperview];
        _headView = nil;
    }
}

- (void) loadFootView{
    if(!_footView){
        _footView = [self getListMoreView];
        _footView.delegate = self;
        CGFloat height = VIEW_HEIGHT(_footView);
        CGFloat top = MAX(self.frame.size.height, self.contentSize.height);
        if(self.constraints.count > 0 || !self.translatesAutoresizingMaskIntoConstraints){
            _footView.translatesAutoresizingMaskIntoConstraints = NO;
            _topConstraint = [NSLayoutConstraint constraintWithItem:_footView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0f
                                                                              constant:top];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_footView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_footView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0f
                                                                                 constant:height];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_footView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1.0f
                                                                                constant:VIEW_WIDTH(self)];
            [self addSubview:_footView];
            [self addConstraint:_topConstraint];
            [self addConstraint:leftConstraint];
            [self addConstraint:widthConstraint];
            [self addConstraint:heightConstraint];
            [_footView setNeedsLayout];
            [_footView layoutIfNeeded];
        }else{
            [self addSubview:_footView];
            SET_VIEW_TOP(_footView, top);
            SET_VIEW_LEFT(_footView, 0);
            SET_VIEW_WIDTH(_footView, VIEW_WIDTH(self));
            SET_VIEW_HEIGHT(_footView, height);
        }
    }
}

- (void) removeFootView{
    if(_footView){
        [_footView removeFromSuperview];
        _footView = nil;
        _topConstraint = nil;
    }
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    //设置顶部区域
    SET_VIEW_TOP(self.headView, -VIEW_HEIGHT(self.headView));
    SET_VIEW_LEFT(self.headView, 0);
    SET_VIEW_WIDTH(self.headView, VIEW_WIDTH(self));
    
    //设置底部区域
    CGFloat footerViewTop = MAX(self.frame.size.height, self.contentSize.height);
    if(_topConstraint)
        _topConstraint.constant = footerViewTop;
    else
        SET_VIEW_TOP(self.footView, footerViewTop);
}

- (XHeadView *) getListHeadView{
    return nil;
}

- (XFootView *) getListMoreView{
    return nil;
}

- (CGFloat) getPerLoadRate{
    return PER_LOADRATE;
}

- (CGFloat) getLoadTimeOut{
    return LOAD_TIMEOUT;
}

- (void) finishLoad{
    if(_headView && [_headView bLoading]){
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(weakSelf.headView)
                [weakSelf.headView stopLoading];
        });
    }
    
    if(_footView && [_footView bLoading]){
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(weakSelf.footView)
                [weakSelf.footView stopLoading];
        });
    }
}

//当前是否支持下拉刷新
- (BOOL) bPullToDown{
    return _listStyle == XListViewStyleStandard || _listStyle == XListViewStyleHeader;
}

//当前是否支持上拉加载更多
- (BOOL) bPullToUp{
    return _listStyle == XListViewStyleStandard || _listStyle == XListViewStyleFooter;
}

- (void) reloadData{
    [super reloadData];
}

#pragma mark --
#pragma mark --XHeadViewDelegate
- (void)didTriggerRefresh:(XHeadView *) refreshView{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(LOAD_TIMEOUT);
        [weakSelf finishLoad];
    });
}

#pragma mark --
#pragma mark --XFootViewDelegate
- (void)didTriggerLoadMore:(XFootView *)loadMoreView{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(LOAD_TIMEOUT);
        [weakSelf finishLoad];
    });
}

#pragma mark --
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当前是否正在加载
    if([self bLoading]){
        return;
    }
    
    if(CFAbsoluteTimeGetCurrent() - _lastTimeInterval >= SAMPLING_RATE){
        if(scrollView.contentOffset.y <= 0){
            if([self bPullToDown]){
                [_headView scrollViewDidScroll:scrollView];
            }
        }else{
            if([self bPullToUp]){
                if(scrollView.frame.size.height >= self.contentSize.height){
                    //内容较少的情况，滚动不可用的情况
                    
                }else{
                    if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
                        [_footView scrollViewDidScroll:scrollView];
                    }
                }
            }
        }
        
        _lastY = scrollView.contentOffset.y;
        _lastTimeInterval = CFAbsoluteTimeGetCurrent();
    }
    
    if(_messageInterceotor){
        if(_messageInterceotor.delegateReceiver != self){
            if([_messageInterceotor.delegateReceiver respondsToSelector:@selector(scrollViewDidScroll:)]){
                [_messageInterceotor.delegateReceiver scrollViewDidScroll:scrollView];
            }
        }else if(_messageInterceotor.dataSourceReceiver != self){
            if([_messageInterceotor.dataSourceReceiver respondsToSelector:@selector(scrollViewDidScroll:)]){
                [_messageInterceotor.dataSourceReceiver scrollViewDidScroll:scrollView];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y <= 0){
        [_headView scrollViewWillBeginDragging:scrollView];
    }else{
        if(scrollView.frame.size.height >= self.contentSize.height){
            //内容较少的情况，滚动不可用的情况
            
        }else{
            if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
                [_footView scrollViewWillBeginDragging:scrollView];
            }
        }
    }
    
    if(_messageInterceotor){
        if(_messageInterceotor.delegateReceiver != self){
            if([_messageInterceotor.delegateReceiver respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
                [_messageInterceotor.delegateReceiver scrollViewWillBeginDragging:scrollView];
            }
        }else if(_messageInterceotor.dataSourceReceiver != self){
            if([_messageInterceotor.dataSourceReceiver respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
                [_messageInterceotor.dataSourceReceiver scrollViewWillBeginDragging:scrollView];
            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(scrollView.contentOffset.y <= 0){
        [_headView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }else{
        if(scrollView.frame.size.height >= self.contentSize.height){
            //内容较少的情况，滚动不可用的情况
            
        }else{
            if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
                [_footView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
            }
        }
    }
    
    if(_messageInterceotor){
        if(_messageInterceotor.delegateReceiver != self){
            if([_messageInterceotor.delegateReceiver respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
                [_messageInterceotor.delegateReceiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
            }
        }else if(_messageInterceotor.dataSourceReceiver != self){
            if([_messageInterceotor.dataSourceReceiver respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
                [_messageInterceotor.dataSourceReceiver scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
            }
        }
    }
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y <= 0){
        [_headView scrollViewWillBeginDecelerating:scrollView];
    }else{
        if(scrollView.frame.size.height >= self.contentSize.height){
            //内容较少的情况，滚动不可用的情况
            
        }else{
            if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
                [_footView scrollViewWillBeginDecelerating:scrollView];
            }
        }
    }
    
    if(_messageInterceotor){
        if(_messageInterceotor.delegateReceiver != self){
            if([_messageInterceotor.delegateReceiver respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]){
                [_messageInterceotor.delegateReceiver scrollViewWillBeginDecelerating:scrollView];
            }
        }else if(_messageInterceotor.dataSourceReceiver != self){
            if([_messageInterceotor.dataSourceReceiver respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]){
                [_messageInterceotor.dataSourceReceiver scrollViewWillBeginDecelerating:scrollView];
            }
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y <= 0){
        [_headView scrollViewDidEndDecelerating:scrollView];
    }else{
        if(scrollView.frame.size.height >= self.contentSize.height){
            //内容较少的情况，滚动不可用的情况
            
        }else{
            if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
                [_footView scrollViewDidEndDecelerating:scrollView];
            }
        }
    }
    
    if(_messageInterceotor){
        if(_messageInterceotor.delegateReceiver != self){
            if([_messageInterceotor.delegateReceiver respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
                [_messageInterceotor.delegateReceiver scrollViewDidEndDecelerating:scrollView];
            }
        }else if(_messageInterceotor.dataSourceReceiver != self){
            if([_messageInterceotor.dataSourceReceiver respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
                [_messageInterceotor.dataSourceReceiver scrollViewDidEndDecelerating:scrollView];
            }
        }
    }
    
}

@end
