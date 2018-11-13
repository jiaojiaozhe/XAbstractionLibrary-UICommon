//
//  XCollectionView.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/20.
//

#import "XCollectionView.h"
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
#define         SAMPLING_RATE           0.2f

@interface XCollectionView()<XListHeadViewDelegate,XListFootViewDelegate>

@property (nonatomic,strong) XLock *lock;

/**
 *  头部控件
 */
@property (nonatomic,strong) XListHeadView *headView;

/**
 *  底部控件
 */
@property (nonatomic,strong) XListFootView *footView;

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
@property (nonatomic,weak) NSLayoutConstraint *footTopConstraint;
/**
 *  处理底部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *footWidthConstraint;
/**
 *  处理底部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *footHeightConstraint;
/**
 *  处理底部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *footLeftConstraint;
/**
 *  处理顶部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *headTopConstraint;
/**
 *  处理顶部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *headLeftConstraint;
/**
 *  处理顶部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *headHeightConstraint;
/**
 *  处理顶部控件位置的问题
 */
@property (nonatomic,weak) NSLayoutConstraint *headWidthConstraint;


@end

@implementation XCollectionView
@synthesize headView = _headView;
@synthesize footView = _footView;
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

- (instancetype) initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
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
    
    if(!bLoading){
        bLoading = _bLoading;
    }
    [_lock unlock];
    return bLoading;
}

- (void) setBLoading:(BOOL)bLoading{
    [_lock lock];
    _bLoading = bLoading;
    [_lock unlock];
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

- (void) setDelegate:(id<UICollectionViewDelegate>)delegate{
    if(self.messageInterceotor){
        self.messageInterceotor.delegateReceiver = delegate;
        if(delegate){
            super.delegate = (id<UICollectionViewDelegate>)self.messageInterceotor;
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

- (void) setDataSource:(id<UICollectionViewDataSource>)dataSource{
    if(self.messageInterceotor){
        self.messageInterceotor.dataSourceReceiver = dataSource;
        if(dataSource){
            super.dataSource = (id<UICollectionViewDataSource>)self.messageInterceotor;
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
        //[self removeRefreshView];
        //[self removeFootView];
        [self loadRefreshView];
        [self loadFootView];
    }
    else if(_listStyle == XListViewStyleHeader){
        //[self removeRefreshView];
        //[self removeFootView];
        [self loadRefreshView];
    }
    else if(_listStyle == XListViewStyleFooter){
        //[self removeRefreshView];
        //[self removeFootView];
        [self loadFootView];
    }
    else{
        [self removeRefreshView];
        [self removeFootView];
    }
}

- (void) loadRefreshView{
    if(![self headView]){
        XListHeadView *listHeadView = [self getListHeadView];
        if(!listHeadView){
            return;
        }
        
        [self setHeadView:listHeadView];
    }
    
    [[self headView] setDelegate:self];
    CGFloat height = VIEW_HEIGHT([self headView]);
    if(self.constraints.count > 0 || !self.translatesAutoresizingMaskIntoConstraints){
        [self headView].translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:[self headView]];
        if(!_headTopConstraint){
            _headTopConstraint = [NSLayoutConstraint constraintWithItem:[self headView]
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0f
                                                               constant:-(height)];
            [self addConstraint:_headTopConstraint];
        }
        
        if(!_headLeftConstraint){
            _headLeftConstraint = [NSLayoutConstraint constraintWithItem:[self headView]
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0.0f];
            [self addConstraint:_headLeftConstraint];
        }
        
        if(!_headHeightConstraint){
            _headHeightConstraint = [NSLayoutConstraint constraintWithItem:[self headView]
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0f
                                                                  constant:height];
            [self addConstraint:_headWidthConstraint];
        }
        
        if(!_headWidthConstraint){
            _headWidthConstraint = [NSLayoutConstraint constraintWithItem:[self headView]
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0f
                                                                 constant:0.0];
            [self addConstraint:_headHeightConstraint];
        }
        
        [[self headView] setNeedsLayout];
        [[self headView] layoutIfNeeded];
    }else{
            [self addSubview:[self headView]];
            SET_VIEW_TOP([self headView], -(VIEW_HEIGHT([self headView])));
            SET_VIEW_LEFT([self headView], 0);
            SET_VIEW_WIDTH([self headView], VIEW_WIDTH(self));
            SET_VIEW_HEIGHT([self headView], VIEW_HEIGHT([self headView]));
        }
}

- (void) removeRefreshView{
    if([self headView]){
        [[self headView] removeFromSuperview];
        if(_headTopConstraint){
            [self  removeConstraint:_headTopConstraint];
            _headTopConstraint = nil;
        }
        
        if(_headLeftConstraint){
            [self removeConstraint:_headLeftConstraint];
            _headLeftConstraint = nil;
        }
        
        if(_headWidthConstraint){
            [self removeConstraint:_headWidthConstraint];
            _headWidthConstraint = nil;
        }
        
        if(_headHeightConstraint){
            [self removeConstraint:_headHeightConstraint];
            _headHeightConstraint = nil;
        }
        [self setHeadView:nil];
    }
}

- (void) loadFootView{
    
    if(![self footView]){
        XListFootView *listFoodView = [self getListMoreView];
        if(!listFoodView){
            return;
        }
        
        [self setFootView:listFoodView];
    }
    
    [[self footView] setDelegate:self];
    CGFloat height = VIEW_HEIGHT([self footView]);
    CGFloat top = MAX(self.frame.size.height, self.contentSize.height);
    if(self.constraints.count > 0 || !self.translatesAutoresizingMaskIntoConstraints){
        [self footView].translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:[self footView]];
        if(!_footTopConstraint){
            _footTopConstraint = [NSLayoutConstraint constraintWithItem:[self footView]
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:0];
            [self addConstraint:_footTopConstraint];
        }
        
        if(!_footLeftConstraint){
            _footLeftConstraint = [NSLayoutConstraint constraintWithItem:[self footView]
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0.0f];
            [self addConstraint:_footLeftConstraint];
        }
        
        if(!_footWidthConstraint){
            _footWidthConstraint = [NSLayoutConstraint constraintWithItem:[self footView]
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:1.0f
                                                                 constant:0];
            [self addConstraint:_footWidthConstraint];
        }
        
        if(!_footHeightConstraint){
            _footHeightConstraint = [NSLayoutConstraint constraintWithItem:[self footView]
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0f
                                                                  constant:height];
            [self addConstraint:_footHeightConstraint];
        }
        
        [[self footView] setNeedsLayout];
        [[self footView] layoutIfNeeded];
    }else{
            [self addSubview:[self footView]];
            SET_VIEW_TOP([self footView], top);
            SET_VIEW_LEFT([self footView], 0);
            SET_VIEW_WIDTH([self footView], VIEW_WIDTH(self));
            SET_VIEW_HEIGHT([self footView], height);
        }
}

- (void) removeFootView{
    if([self footView]){
        [[self footView] removeFromSuperview];
        if(_footTopConstraint){
            [self removeConstraint:_footTopConstraint];
            _footTopConstraint = nil;
        }
        
        if(_footLeftConstraint){
            [self removeConstraint:_footLeftConstraint];
            _footLeftConstraint = nil;
        }
        
        if(_footWidthConstraint){
            [self removeConstraint:_footWidthConstraint];
            _footWidthConstraint = nil;
        }
        
        if(_footHeightConstraint){
            [self removeConstraint:_footHeightConstraint];
            _footHeightConstraint = nil;
        }
        
        [self setFootView:nil];
    }
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    //设置顶部区域
    SET_VIEW_TOP([self headView], -VIEW_HEIGHT([self headView]));
    SET_VIEW_LEFT([self headView], 0);
    SET_VIEW_WIDTH([self headView], VIEW_WIDTH(self));
    
    //设置底部区域
    CGFloat footerViewTop = MAX(self.frame.size.height, self.contentSize.height);
    if(_footTopConstraint)
        _footTopConstraint.constant = footerViewTop;
    else
        SET_VIEW_TOP([self footView], footerViewTop);
}

- (void) setHeadView:(XListHeadView *)headView{
    [_lock lock];
    _headView = headView;
    [_lock unlock];
}

- (XListHeadView *)headView{
    XListHeadView *headView = nil;
    [_lock lock];
    headView = _headView;
    [_lock unlock];
    return headView;
}

- (void)setFootView:(XListFootView *)footView{
    [_lock lock];
    _footView = footView;
    [_lock unlock];
}

- (XListFootView *)footView{
    XListFootView *footView = nil;
    [_lock lock];
    footView = _footView;
    [_lock unlock];
    return footView;
}

- (XListHeadView *) getListHeadView{
    return [self headView];
}

- (XListFootView *) getListMoreView{
    return [self footView];
}

- (CGFloat) getPerLoadRate{
    return PER_LOADRATE;
}

- (CGFloat) getLoadTimeOut{
    return LOAD_TIMEOUT;
}

- (void) finishLoad{
    if([self headView] && [[self headView] bLoading]){
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([weakSelf headView])
                [[weakSelf headView] stopLoading];
        });
    }
    
    if([self footView] && [[self footView] bLoading]){
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            if([weakSelf footView])
                [[weakSelf footView] stopLoading];
        });
    }
    
    [self setBLoading:NO];
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
#pragma mark --XListHeadViewDelegate
- (void)didTriggerRefresh:(XListHeadView *) refreshView{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(LOAD_TIMEOUT);
        [weakSelf finishLoad];
    });
}

#pragma mark --
#pragma mark --XFootViewDelegate
- (void)didTriggerLoadMore:(XListFootView *)loadMoreView{
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
    
    //预加载处理
    if(VIEW_HEIGHT(self) * [self getPerLoadRate] < self.contentSize.height){
        if([self bPullToUp]){
            if(![self bLoading]){
                if(self.contentOffset.y + VIEW_HEIGHT(self) * [self getPerLoadRate] >= self.contentSize.height){
                    [self setBLoading:YES];
                    [self didTriggerLoadMore:_footView];
                }
            }
        }
    }
    
    if(CFAbsoluteTimeGetCurrent() - _lastTimeInterval >= SAMPLING_RATE){
        if(scrollView.contentOffset.y <= 0){
            if([self bPullToDown]){
                [[self headView] scrollViewDidScroll:scrollView];
            }
        }else{
            if([self bPullToUp]){
                if(VIEW_HEIGHT(self) >= self.contentSize.height){
                    [[self footView] scrollViewDidScroll:scrollView];
                }else if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
                    [[self footView] scrollViewDidScroll:scrollView];
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
        [[self headView] scrollViewWillBeginDragging:scrollView];
    }else{
        if(VIEW_HEIGHT(self) >= self.contentSize.height){
            [[self footView] scrollViewWillBeginDragging:scrollView];
        }else if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
            [[self footView] scrollViewWillBeginDragging:scrollView];
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
        [[self headView] scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }else{
        if(VIEW_HEIGHT(self) >= self.contentSize.height){
            [[self footView] scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }else if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
            [[self footView] scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
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
        [[self headView] scrollViewWillBeginDecelerating:scrollView];
    }else{
        if(VIEW_HEIGHT(self) >= self.contentSize.height){
            [[self footView] scrollViewWillBeginDecelerating:scrollView];
        }else if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
            [[self footView] scrollViewWillBeginDecelerating:scrollView];
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
        [[self headView] scrollViewDidEndDecelerating:scrollView];
    }else{
        if(VIEW_HEIGHT(self) >= self.contentSize.height){
            [[self footView] scrollViewDidEndDecelerating:scrollView];
        }else if(scrollView.contentOffset.y + VIEW_HEIGHT(scrollView) >= scrollView.contentSize.height){
            [[self footView] scrollViewDidEndDecelerating:scrollView];
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
