//
//  XBaseView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import "XBaseView.h"
#import "XXNibBridge.h"
#import <XAbstractionLibrary_NetWork/XAbstractionLibrary-NetWork-umbrella.h>


@interface XBaseView()<XXNibBridge>
@property (nonatomic,strong) UIView *subContentView;
@property (nonatomic,strong) IBOutlet UIView *contentView;
@property (nonatomic,strong) IBOutlet UIView *errorContentView;

/**
 是否存在网络状态
 */
@property (nonatomic,assign) BOOL bNotNet;

/**
 是否无数据
 */
@property (nonatomic,assign) BOOL bNotData;

/**
 是否正在加载中
 */
@property (nonatomic,assign) BOOL bLoading;

/**
 是否存在加载错误
 */
@property (nonatomic,assign) BOOL bError;

/**
 是否最终忽略上述各状态，一般用于成功加载后
 */
@property (nonatomic,assign) BOOL bIgnoreShowError;

@property (nonatomic,strong) XLock *lock;
@property (nonatomic,strong) XLock *uiLock;
@property (nonatomic,strong) id<XIBaseLoadingViewDelegate> loadingViewDelegate;
@property (nonatomic,strong) id<XIBaseErrorViewDelegate> errorViewDelegate;
@property (nonatomic,strong) id<XIBaseNotNetViewDelegate> notNetViewDelegate;
@property (nonatomic,strong) id<XIBaseNotDataViewDelegate> notDataViewDelegate;

@property (nonatomic,strong) NSMutableDictionary *requests;
@end

@implementation XBaseView
@synthesize bNotNet = _bNotNet;
@synthesize bNotData = _bNotData;
@synthesize bLoading = _bLoading;
@synthesize bError = _bError;
@synthesize bIgnoreShowError = _bIgnoreShowEerror;
@synthesize loadingViewDelegate = _loadingViewDelegate;
@synthesize errorViewDelegate = _errorViewDelegate;
@synthesize notNetViewDelegate = _notNetViewDelegate;
@synthesize notDataViewDelegate = _notDataViewDelegate;

+ (instancetype) createView{
//    NSString *className = NSStringFromClass([self class]);
//    NSBundle *bundle = [NSBundle bundleForClass:[XBaseView class]];
//    XBaseView *view = [[bundle loadNibNamed:className
//                                  owner:nil
//                                options:nil] firstObject];
    
    XBaseView *view = [[[self class] alloc] init];
    [view awakeFromNib];
    return view;
}

- (instancetype) init{
    if(self = [super init]){
        self.requests = [NSMutableDictionary dictionary];
        
        if(!self.contentView){
            self.contentView = [[UIView alloc] init];
            self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:self.contentView];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0f
                                                                                constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                                attribute:NSLayoutAttributeBottom
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeBottom
                                                                               multiplier:1.0f
                                                                                 constant:0];
            [self addConstraint:leftConstraint];
            [self addConstraint:bottomConstraint];
            [self addConstraint:rightConstraint];
            [self addConstraint:topConstraint];
            [self.contentView setNeedsLayout];
            [self.contentView layoutIfNeeded];
        }
        
        if(!self.errorContentView){
            self.errorContentView = [[UIView alloc] init];
            [self addSubview:self.errorContentView];
            self.errorContentView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.errorContentView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.errorContentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.errorContentView
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0f
                                                                                constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.errorContentView
                                                                                attribute:NSLayoutAttributeBottom
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeBottom
                                                                               multiplier:1.0f
                                                                                 constant:0];
            [self addConstraint:leftConstraint];
            [self addConstraint:bottomConstraint];
            [self addConstraint:rightConstraint];
            [self addConstraint:topConstraint];
            [self.errorContentView setNeedsLayout];
            [self.errorContentView layoutIfNeeded];
            [self.errorContentView setHidden:YES];
        }
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self setupData];
    [self.contentView setHidden:NO];
    [self.errorContentView setHidden:YES];
    
    //初始化数据
    [self initData];
    
    [self setContentView];
    [self setNotNetView];
    [self setLoadingView];
    [self setErrorView];
    [self setNotDataView];
    
    if(![self notNetViewDelegate] &&
       ![self loadingViewDelegate] &&
       ![self errorViewDelegate] &&
       ![self notDataViewDelegate]){
        if(self.errorContentView){
            [self.errorContentView removeFromSuperview];
            self.errorContentView = NULL;
        }
    }
    
    [self initView];
    
    if(![[XNetWorkStatus shareNetkStatus] bGoodNet]){
        //显示无网页面
        [self setBNotNet:YES];
    }else{
        //开始加载
        [self setBNotNet:NO];
        [self loadPage];
    }
    [self refreshStatusView];
}

- (void) setupData{
    _lock = [[XLock alloc] init];
    _uiLock = [[XLock alloc] init];
    [self initState];
}

- (void) onSendMyBroadcast:(XNotification_Action) action dataInfo:(id) dataInfo{
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dataInfo];
    [data setObject:@(action) forKey:NOTIFICATION_ACTION];
    [[NSNotificationCenter defaultCenter] postNotificationName:GLOBAL_UI_ACTION_NOTIFICATION
                                                        object:data];
}

- (void) onMyBroadcastReceiver:(NSNotification *) notification{
    if(notification && [notification.name isEqualToString:GLOBAL_UI_ACTION_NOTIFICATION]){
        XNotification_Action action = [[[notification userInfo] objectForKey:NOTIFICATION_ACTION] integerValue];
        if(action != XNotification_Action_NetWork){
            return;
        }
        
        if([XNetWorkStatus shareNetkStatus].bGoodNet){
            if([XNetWorkStatus shareNetkStatus].netWorkStatus == XNetworkReachabilityStatusReachableViaWWAN){
                if(![self bIgnoreShowError] && [self bNotNet]){
                    [self retryNotNet:NO];
                }else{
                    [self setBNotNet:NO];
                    [self refreshStatusView];
                }
            }else if([XNetWorkStatus shareNetkStatus].netWorkStatus == XNetworkReachabilityStatusReachableViaWiFi){
                if(![self bIgnoreShowError] && [self bNotNet]){
                    [self retryNotNet:NO];
                }else{
                    [self setBNotNet:NO];
                    [self refreshStatusView];
                }
            }else{
                [self setBNotNet:YES];
                [self refreshStatusView];
            }
        }else{
            [self setBNotNet:YES];
            [self refreshStatusView];
            
            for(NSInteger index = [self.requests count] - 1; index >= 0 ; index--){
                NSString *key = [[self.requests allKeys] objectAtIndex:index];
                id<XHttpRequestDelegate> request = [self.requests objectForKey:key];
                if(request && [request isKindOfClass:[XBaseHttpRequest class]]){
                    XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
                    [httpRequest cancel];
                }
            }
        }
    }
}

- (void) setBError:(BOOL)bError{
    [_lock lock];
    _bError = bError;
    [_lock unlock];
}

- (BOOL) bError{
    BOOL err = NO;
    [_lock lock];
    err = _bError;
    [_lock unlock];
    return err;
}

- (void) setBNotNet:(BOOL)bNotNet{
    [_lock lock];
    _bNotNet = bNotNet;
    [_lock unlock];
}

- (BOOL) bNotNet{
    BOOL notNet = NO;
    [_lock lock];
    notNet = _bNotNet;
    [_lock unlock];
    return notNet;
}

- (void) setBLoading:(BOOL)bLoading{
    [_lock lock];
    _bLoading = bLoading;
    [_lock unlock];
}

- (BOOL) bLoading{
    BOOL loading = NO;
    [_lock lock];
    loading = _bLoading;
    [_lock unlock];
    return loading;
}

- (void) setBNotData:(BOOL)bNotData{
    [_lock lock];
    _bNotData = bNotData;
    [_lock unlock];
}

- (BOOL) bNotData{
    BOOL notData = NO;
    [_lock lock];
    notData = _bNotData;
    [_lock unlock];
    return notData;
}

- (void) setBIgnoreShowError:(BOOL)bIgnoreShowError{
    [_lock lock];
    _bIgnoreShowEerror = bIgnoreShowError;
    [_lock unlock];
}

- (BOOL) bIgnoreShowError{
    BOOL ignoreShowError = NO;
    [_lock lock];
    ignoreShowError = _bIgnoreShowEerror;
    [_lock unlock];
    return ignoreShowError;
}

- (void) setLoadingViewDelegate:(id<XIBaseLoadingViewDelegate>)loadingViewDelegate{
    [_lock lock];
    _loadingViewDelegate = loadingViewDelegate;
    [_lock unlock];
}

- (id<XIBaseLoadingViewDelegate>) loadingViewDelegate{
    id<XIBaseLoadingViewDelegate> loadingView = nil;
    [_lock lock];
    loadingView = _loadingViewDelegate;
    [_lock unlock];
    return loadingView;
}

- (void) setErrorViewDelegate:(id<XIBaseErrorViewDelegate>)errorViewDelegate{
    [_lock lock];
    _errorViewDelegate = errorViewDelegate;
    [_lock unlock];
}

- (id<XIBaseErrorViewDelegate>) errorViewDelegate{
    id<XIBaseErrorViewDelegate> errorView = nil;
    [_lock lock];
    errorView = _errorViewDelegate;
    [_lock unlock];
    return errorView;
}

- (void) setNotNetViewDelegate:(id<XIBaseNotNetViewDelegate>)notNetViewDelegate{
    [_lock lock];
    _notNetViewDelegate = notNetViewDelegate;
    [_lock unlock];
}

- (id<XIBaseNotNetViewDelegate>) notNetViewDelegate{
    id<XIBaseNotNetViewDelegate> notNetView = nil;
    [_lock lock];
    notNetView = _notNetViewDelegate;
    [_lock unlock];
    return notNetView;
}

- (void) setNotDataViewDelegate:(id<XIBaseNotDataViewDelegate>)notDataViewDelegate{
    [_lock lock];
    _notDataViewDelegate = notDataViewDelegate;
    [_lock unlock];
}

- (id<XIBaseNotDataViewDelegate>) notDataViewDelegate{
    id<XIBaseNotDataViewDelegate> notDataView = nil;
    [_lock lock];
    notDataView = _notDataViewDelegate;
    [_lock unlock];
    return notDataView;
}

- (void) setNotNetView{
    if([self notNetViewDelegate])
        return;
    [self setNotNetViewDelegate:[self loadNotNetView]];
    if([self notNetViewDelegate]){
        if(self.errorContentView){
            UIView *notNetView = (UIView*)[self notNetViewDelegate];
            notNetView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:notNetView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.errorContentView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:notNetView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.errorContentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:notNetView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.errorContentView
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1.0f
                                                                                 constant:0];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:notNetView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.errorContentView
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1.0f
                                                                                constant:0];
            [self.errorContentView addSubview:notNetView];
            [self.errorContentView addConstraint:leftConstraint];
            [self.errorContentView addConstraint:topConstraint];
            [self.errorContentView addConstraint:widthConstraint];
            [self.errorContentView addConstraint:heightConstraint];
            [notNetView setNeedsLayout];
            [notNetView layoutIfNeeded];
            [notNetView setHidden:YES];
        }
    }
}

- (void) setErrorView{
    if([self errorViewDelegate])
        return;
    [self setErrorViewDelegate:[self loadErrorView]];
    if([self errorViewDelegate]){
        if(self.errorContentView){
            UIView *errorView = (UIView*)[self errorViewDelegate];
            errorView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:errorView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.errorContentView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:errorView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.errorContentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:errorView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.errorContentView
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1.0f
                                                                                 constant:0];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:errorView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.errorContentView
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1.0f
                                                                                constant:0];
            [self.errorContentView addSubview:errorView];
            [self.errorContentView addConstraint:leftConstraint];
            [self.errorContentView addConstraint:topConstraint];
            [self.errorContentView addConstraint:widthConstraint];
            [self.errorContentView addConstraint:heightConstraint];
            [errorView setNeedsLayout];
            [errorView layoutIfNeeded];
            [errorView setHidden:YES];
        }
    }
}

- (void) setNotDataView{
    if([self notDataViewDelegate])
        return;
    [self setNotDataViewDelegate:[self loadNotDataView]];
    if([self notDataViewDelegate]){
        if(self.errorContentView){
            UIView *notDataView = (UIView*)[self notDataViewDelegate];
            notDataView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:notDataView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.errorContentView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:notDataView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.errorContentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:notDataView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.errorContentView
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1.0f
                                                                                 constant:0];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:notDataView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.errorContentView
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1.0f
                                                                                constant:0];
            [self.errorContentView addSubview:notDataView];
            [self.errorContentView addConstraint:leftConstraint];
            [self.errorContentView addConstraint:topConstraint];
            [self.errorContentView addConstraint:widthConstraint];
            [self.errorContentView addConstraint:heightConstraint];
            [notDataView setNeedsLayout];
            [notDataView layoutIfNeeded];
            [notDataView setHidden:YES];
        }
    }
}

- (void) setLoadingView{
    if([self loadingViewDelegate]){
        return;
    }
    [self setLoadingViewDelegate:[self loadLoadingView]];
    if([self loadingViewDelegate]){
        if(self.errorContentView){
            UIView *loadingView = (UIView*)[self loadingViewDelegate];
            loadingView.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:loadingView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.errorContentView
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:loadingView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.errorContentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:loadingView
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.errorContentView
                                                                                attribute:NSLayoutAttributeHeight
                                                                               multiplier:1.0f
                                                                                 constant:0];
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:loadingView
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.errorContentView
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1.0f
                                                                                constant:0];
            [self.errorContentView addSubview:loadingView];
            [self.errorContentView addConstraint:leftConstraint];
            [self.errorContentView addConstraint:topConstraint];
            [self.errorContentView addConstraint:widthConstraint];
            [self.errorContentView addConstraint:heightConstraint];
            [loadingView setNeedsLayout];
            [loadingView layoutIfNeeded];
            [loadingView setHidden:YES];
        }
    }
}

- (void) setContentView{
    if(self.subContentView){
        return;
    }
    UIView *contentView = [self getContentView];
    self.subContentView = contentView;
    if(contentView != NULL){
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.contentView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0f
                                                                          constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.contentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0f];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.contentView
                                                                            attribute:NSLayoutAttributeHeight
                                                                           multiplier:1.0f
                                                                             constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.contentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.0f
                                                                            constant:0];
        [self.contentView addSubview:contentView];
        [self.contentView addConstraint:leftConstraint];
        [self.contentView addConstraint:topConstraint];
        [self.contentView addConstraint:widthConstraint];
        [self.contentView addConstraint:heightConstraint];
        [contentView setNeedsLayout];
        [contentView layoutIfNeeded];
    }
}

- (void) initState{
    [self setBNotNet:NO];
    [self setBLoading:NO];
    [self setBError:NO];
    [self setBNotData:NO];
    [self setBIgnoreShowError:NO];
}

- (void) showContentView{
    if(self.contentView){
        [self.contentView setHidden:NO];
    }
    
    if(self.errorContentView){
        [self.errorContentView setHidden:YES];
    }
    
    if([self loadingViewDelegate]){
        [[self loadingViewDelegate] visibleLoading:NO];
    }
    
    if([self errorViewDelegate]){
        [[self errorViewDelegate] visibleErrorView:NO];
    }
    
    if([self notNetViewDelegate]){
        [[self notNetViewDelegate] visibleNotNet:NO];
    }
    
    if([self notDataViewDelegate]){
        [[self notDataViewDelegate] visibleNoData:NO];
    }
}

- (void) showLoadingView{
    if(self.contentView){
        [self.contentView setHidden:YES];
    }
    
    if(self.errorContentView){
        [self.errorContentView setHidden:NO];
    }
    
    if([self loadingViewDelegate]){
        [[self loadingViewDelegate] visibleLoading:YES];
    }
    
    if([self errorViewDelegate]){
        [[self errorViewDelegate] visibleErrorView:NO];
    }
    
    if([self notNetViewDelegate]){
        [[self notNetViewDelegate] visibleNotNet:NO];
    }
    
    if([self notDataViewDelegate]){
        [[self notDataViewDelegate] visibleNoData:NO];
    }
}

- (void) showErrorView{
    if(self.contentView){
        [self.contentView setHidden:YES];
    }
    
    if(self.errorContentView){
        [self.errorContentView setHidden:NO];
    }
    
    if([self loadingViewDelegate]){
        [[self loadingViewDelegate] visibleLoading:NO];
    }
    
    if([self errorViewDelegate]){
        [[self errorViewDelegate] visibleErrorView:YES];
    }
    
    if([self notNetViewDelegate]){
        [[self notNetViewDelegate] visibleNotNet:NO];
    }
    
    if([self notDataViewDelegate]){
        [[self notDataViewDelegate] visibleNoData:NO];
    }
}

- (void) showNotNetView{
    if(self.contentView){
        [self.contentView setHidden:YES];
    }
    
    if(self.errorContentView){
        [self.errorContentView setHidden:NO];
    }
    
    if([self loadingViewDelegate]){
        [[self loadingViewDelegate] visibleLoading:NO];
    }
    
    if([self errorViewDelegate]){
        [[self errorViewDelegate] visibleErrorView:NO];
    }
    
    if([self notNetViewDelegate]){
        [[self notNetViewDelegate] visibleNotNet:YES];
    }
    
    if([self notDataViewDelegate]){
        [[self notDataViewDelegate] visibleNoData:NO];
    }
}

- (void) showNotDataView{
    if(self.contentView){
        [self.contentView setHidden:YES];
    }
    
    if(self.errorContentView){
        [self.errorContentView setHidden:NO];
    }
    
    if([self loadingViewDelegate]){
        [[self loadingViewDelegate] visibleLoading:NO];
    }
    
    if([self errorViewDelegate]){
        [[self errorViewDelegate] visibleErrorView:NO];
    }
    
    if([self notNetViewDelegate]){
        [[self notNetViewDelegate] visibleNotNet:NO];
    }
    
    if([self notDataViewDelegate]){
        [[self notDataViewDelegate] visibleNoData:YES];
    }
}

- (void) refreshStatusView{
    __weak typeof(self) weakSelf = self;
    [_uiLock lock:^{
        if([weakSelf bIgnoreShowError]){
            [weakSelf showContentView];
            return ;
        }
        
        if([weakSelf bNotNet]){
            if([weakSelf notNetViewDelegate]){
                [weakSelf showNotNetView];
                return;
            }
        }
        
        if([weakSelf bError]){
            if([weakSelf errorViewDelegate]){
                [weakSelf showErrorView];
                return;
            }
        }
        
        if([weakSelf bNotData]){
            if([weakSelf notDataViewDelegate]){
                [weakSelf showNotDataView];
                return;
            }
        }
        
        if([weakSelf bLoading]){
            if([weakSelf loadingViewDelegate]){
                [weakSelf showLoadingView];
                return;
            }
        }
        
        [weakSelf showContentView];
    }];
}



#pragma mark --
#pragma mark XAbstractView
- (UIView *) getContentView{
    return NULL;
}

- (id<XIBaseLoadingViewDelegate>) loadLoadingView{
    return NULL;
}

- (id<XIBaseErrorViewDelegate>) loadErrorView{
    return NULL;
}

- (id<XIBaseNotNetViewDelegate>) loadNotNetView{
    return NULL;
}

- (id<XIBaseNotDataViewDelegate>) loadNotDataView{
    return NULL;
}

- (void) initView{
    
}

- (void) loadPage{
    
}

- (void) initData{
    
}

#pragma mark --
#pragma mark --XIBaseNoNetViewRetryDelegate
- (void) retryNotNet:(BOOL) bNotNet{
    if(!bNotNet){
        [self initState];
        [self loadPage];
        [self refreshStatusView];
    }else{
        //手动点击无网重试,暂时未定义,可以跳转到系统设置
//        [self initState];
//        [self loadPage];
//        [self refreshView];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark --
#pragma mark --XIBaseRetryDelegate
- (void) retryError{
    [self initState];
    [self loadPage];
    [self refreshStatusView];
}

#pragma mark --
#pragma mark --XIBaseNotDataRetryDelegate
- (void) retryNotData{
    [self initState];
    [self loadPage];
    [self refreshStatusView];
}

#pragma mark --
#pragma mark --XHttpResponseDelegate
- (void) cancelRequest:(id<XHttpRequestDelegate>) request{
    if(request){
        if([request isKindOfClass:[XBaseHttpRequest class]]){
            XBaseHttpRequest *httpRequest = (XBaseHttpRequest*)request;
            if([httpRequest.ID length] > 0){
                [_requests removeObjectForKey:httpRequest.ID];
            }
        }
    }
}

- (void) willStartRequest:(id<XHttpRequestDelegate>) request{
    if(request){
        if([request isKindOfClass:[XBaseHttpRequest class]]){
            XBaseHttpRequest *httpRequest = (XBaseHttpRequest *)request;
            [_requests setObject:httpRequest forKey:httpRequest.ID];
        
            [self setBLoading:YES];
            [self refreshStatusView];
            if([self loadingViewDelegate]){
                [[self loadingViewDelegate] startLoad];
            }
        }
    }
}


- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest{
    if(oldRequest && newRequest){
        if([oldRequest isKindOfClass:[XBaseHttpRequest class]] &&
           [newRequest isKindOfClass:[XBaseHttpRequest class]]){
            XBaseHttpRequest *oldHttpRequest = (XBaseHttpRequest *)oldRequest;
            if([_requests.allKeys containsObject:oldHttpRequest.ID]){
                XBaseHttpRequest *newHttpRequest = (XBaseHttpRequest*)newRequest;
                [_requests setObject:newHttpRequest forKey:oldHttpRequest.ID];
            }
        }
    }
    
    [self setBLoading:YES];
    [self refreshStatusView];
    if([self loadingViewDelegate]){
        [[self loadingViewDelegate] startLoad];
    }
}

- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress{
    if(request){
        if([request isKindOfClass:[XBaseHttpRequest class]]){
            [self setBLoading:YES];
            [self refreshStatusView];
            if([self loadingViewDelegate]){
                [[self loadingViewDelegate] loadProgress:progress totalProgress:totalProgress];
            }
        }
    }
}

- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error{
    if(request){
        if([request isKindOfClass:[XBaseHttpRequest class]]){
            XBaseHttpRequest *httpRequest = (XBaseHttpRequest *)request;
            [_requests removeObjectForKey:httpRequest.ID];
//            [httpRequest cancel];
        }
        
        [self setBLoading:NO];
        [self setBError:error ? YES : NO];
        [self refreshStatusView];
        if([self loadingViewDelegate]){
            [[self loadingViewDelegate] completeLoad:!error ? YES : NO];
        }
    }
}
@end
