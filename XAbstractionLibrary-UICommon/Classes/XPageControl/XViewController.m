//
//  XViewController.m
//  AFNetworking
//
//  Created by lanbiao on 2018/7/20.
//

#import "XView.h"
#import "XViewController.h"

@interface XViewController ()

@property (nonatomic,strong) XView *contentView;

/**
 内容区
 */
@property (nonatomic,strong) IBOutlet UIView *mContentView;

/**
 顶部NavigationBar
 */
@property (nonatomic,strong) IBOutlet UIView *mNavigationBarView;

/**
 navigationBar高度约束
 */
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *mHeightConstraint;

/**
 请求对象的集合
 */
@property (nonatomic,strong) NSMutableDictionary *requests;
@end

@implementation XViewController

+ (instancetype) createViewController{
    XViewController *viewController = [[[self class] alloc] init];
    
    return viewController;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    NSBundle *bundle = [NSBundle bundleForClass:[XViewController class]];
    if(self = [super initWithNibName:nibNameOrNil bundle:bundle]){
        
    }
    return self;
}

- (instancetype) init{
    if(self = [super init]){
        self.requests = [NSMutableDictionary dictionary];
        
        if(!self.mNavigationBarView){
            self.mNavigationBarView = [[UIView alloc] init];
            self.mNavigationBarView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:self.mNavigationBarView];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.mNavigationBarView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.view
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.mNavigationBarView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.mNavigationBarView
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0f
                                                                                constant:0];
            _mHeightConstraint = [NSLayoutConstraint constraintWithItem:self.mNavigationBarView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0f
                                                               constant:0];
            [self.view addConstraint:leftConstraint];
            [self.view addConstraint:_mHeightConstraint];
            [self.view addConstraint:rightConstraint];
            [self.view addConstraint:topConstraint];
            [self.mNavigationBarView setNeedsLayout];
            [self.mNavigationBarView layoutIfNeeded];
        }
        
        if(!self.mContentView){
            self.mContentView = [[UIView alloc] init];
            self.mContentView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:self.mContentView];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:self.mNavigationBarView
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0f
                                                                              constant:0];
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.view
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:0.0f];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0f
                                                                                constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.mContentView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0f
                                                              constant:0];
            [self.view addConstraint:leftConstraint];
            [self.view addConstraint:bottomConstraint];
            [self.view addConstraint:rightConstraint];
            [self.view addConstraint:topConstraint];
            [self.mContentView setNeedsLayout];
            [self.mContentView layoutIfNeeded];
        }
    }
    
    [self setNavigationBar];
    [self setContentView];
    [self registerBroadcastReceiver];
    return self;
}

- (UIView *) loadNavigationBar{
    return NULL;
}

- (void) setNavigationBar{
    UIView *navigationBar = [self loadNavigationBar];
    if(navigationBar){
        navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
        if(_mHeightConstraint){
            _mHeightConstraint.constant = VIEW_HEIGHT(navigationBar);
        }
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:navigationBar
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.mNavigationBarView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0f
                                                                          constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:navigationBar
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.mNavigationBarView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0f];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:navigationBar
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.mNavigationBarView
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0f
                                                                             constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:navigationBar
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.mNavigationBarView
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0f
                                                                            constant:0];
        [self.mNavigationBarView addSubview:navigationBar];
        [self.mNavigationBarView addConstraint:leftConstraint];
        [self.mNavigationBarView addConstraint:topConstraint];
        [self.mNavigationBarView addConstraint:rightConstraint];
        [self.mNavigationBarView addConstraint:bottomConstraint];
        [navigationBar setNeedsLayout];
        [navigationBar layoutIfNeeded];
    }
}

- (XView *) loadContentView{
    return NULL;
}

- (void) setContentView{
    _contentView = [self loadContentView];
    if(_contentView){
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_contentView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.mContentView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0f
                                                                          constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_contentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.mContentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0f];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_contentView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.mContentView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0f
                                                                            constant:0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_contentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.mContentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0f
                                                                             constant:0];
        [self.mContentView addSubview:_contentView];
        [self.mContentView addConstraint:leftConstraint];
        [self.mContentView addConstraint:topConstraint];
        [self.mContentView addConstraint:rightConstraint];
        [self.mContentView addConstraint:bottomConstraint];
        [_contentView setNeedsLayout];
        [_contentView layoutIfNeeded];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)dealloc{
    [self unregisterBroadcastReceiver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) broadcastReceiver:(NSNotification *)notification view:(UIView *) view{
    if(view){
        if([view isKindOfClass:[XView class]]){
            XView *xview = (XView *)view;
            [xview onMyBroadcastReceiver:notification];
        }
        
        NSArray *subViews = [view subviews];
        for(NSInteger index = 0; index < [subViews count]; index++){
            UIView *subView = [subViews objectAtIndex:index];
            if([subView isKindOfClass:[XView class]]){
                XView *xSubVuew = (XView*)subView;
                [xSubVuew onMyBroadcastReceiver:notification];
            }
        }
    }
}

- (void) onMyBroadcastReceiver:(NSNotification *) notification{
    [self broadcastReceiver:notification view:self.contentView];
}

- (void) onSendMyBroadcast:(XNotification_Action) action dataInfo:(NSDictionary *) dataInfo{
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dataInfo];
    [data setObject:@(action) forKey:NOTIFICATION_ACTION];
    [[NSNotificationCenter defaultCenter] postNotificationName:GLOBAL_UI_ACTION_NOTIFICATION
                                                        object:data];
}

- (void) registerBroadcastReceiver{
    [self unregisterBroadcastReceiver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMyBroadcastReceiver:)
                                                 name:GLOBAL_UI_ACTION_NOTIFICATION
                                               object:nil];
}

- (void) unregisterBroadcastReceiver{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:GLOBAL_UI_ACTION_NOTIFICATION
                                                  object:nil];
}

#pragma mark --
#pragma mark --XHttpResponseDelegate
- (void) cancelRequest:(id<XHttpRequestDelegate>) request{
    if(self.contentView &&
       [self.contentView respondsToSelector:@selector(cancelRequest:)]){
        [self.contentView cancelRequest:request];
    }
    
    if(request && [request isKindOfClass:[XHttpRequest class]]){
        XHttpRequest *httpRequest = (XHttpRequest*)request;
        if([httpRequest.ID length] > 0){
            [self.requests removeObjectForKey:httpRequest.ID];
        }
    }
}

- (void) willStartRequest:(id<XHttpRequestDelegate>) request{
    if(self.contentView &&
       [self.contentView respondsToSelector:@selector(willStartRequest:)]){
        [self.contentView willStartRequest:request];
    }
    
    if(request && [request isKindOfClass:[XHttpRequest class]]){
        XHttpRequest *httpRequest = (XHttpRequest*)request;
        if([httpRequest.ID length] > 0){
            [self.requests setObject:httpRequest forKey:httpRequest.ID];
        }
    }
}

- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest{
    if(self.contentView &&
       [self.contentView respondsToSelector:@selector(willRetryRequest:newRequest:)]){
        [self.contentView willRetryRequest:oldRequest newRequest:newRequest];
    }
    
    if(oldRequest &&
       [oldRequest isKindOfClass:[XHttpRequest class]] &&
       newRequest &&
       [newRequest isKindOfClass:[XHttpRequest class]]){
        XHttpRequest *oldHttpRequest = (XHttpRequest*)oldRequest;
        XHttpRequest *newHttpRequest = (XHttpRequest*)newRequest;
        if([oldHttpRequest.ID length] > 0)
            [self.requests removeObjectForKey:oldHttpRequest.ID];
        if([newHttpRequest.ID length] > 0)
            [self.requests setObject:newHttpRequest forKey:newHttpRequest.ID];
    }
}

- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress{
    if(self.contentView &&
       [self.contentView respondsToSelector:@selector(execWithRequest:progress:totalProgress:)]){
        [self.contentView execWithRequest:request
                                 progress:progress
                            totalProgress:totalProgress];
    }
}


- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error{
    if(self.contentView &&
       [self.contentView respondsToSelector:@selector(completeDidRequest:responseDic:error:)]){
        [self.contentView completeDidRequest:request
                                 responseDic:responseDic
                                       error:error];
    }
    
    if(request &&
       [request isKindOfClass:[XHttpRequest class]]){
        XHttpRequest *httpRequest = (XHttpRequest*)request;
        if([httpRequest.ID length] > 0)
            [self.requests removeObjectForKey:httpRequest.ID];
    }
}

@end
