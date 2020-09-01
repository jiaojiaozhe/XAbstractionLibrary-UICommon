//
//  XRefreshContentView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/8/9.
//

#import "XRefreshView.h"
#import "XRefreshContentView.h"

@interface XRefreshContentView()<XListCallBackDelegate>
@property (nonatomic,strong) XLock *lock;
@property (nonatomic,assign) BOOL bRefreshing;
@property (nonatomic,strong) XRefreshView *refreshView;
@end

@implementation XRefreshContentView
@synthesize bRefreshing = _bRefreshing;

- (instancetype) init{
    if(self = [super init]){
        _lock = [[XLock alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _lock = [[XLock alloc] init];
    }
    return self;
}

- (void) setBRefreshing:(BOOL)bRefreshing{
    [_lock lock];
    _bRefreshing = bRefreshing;
    [_lock unlock];
}

- (BOOL) bRefreshing{
    BOOL bRefresh = NO;
    [_lock lock];
    bRefresh = _bRefreshing;
    [_lock unlock];
    return bRefresh;
}

- (UIView *) getContentView{
    if(_refreshView)
        return _refreshView;
    
    Class class = [XRefreshView class];
    NSString *className = NSStringFromClass(class);
    NSBundle *frameWorkBundle = [NSBundle bundleForClass: class];
    NSString *projectName = [[[[frameWorkBundle bundlePath] lastPathComponent] stringByDeletingPathExtension] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
    NSString *frameWorkBundlePath = [frameWorkBundle pathForResource:projectName
                                                              ofType:@"bundle"];
    NSBundle *xibBundle = [NSBundle bundleWithPath:frameWorkBundlePath];
    
    NSArray *viewList = [xibBundle loadNibNamed:className
                                       owner:self
                                     options:nil];
    if([viewList count] > 0){
        _refreshView = [viewList objectAtIndex:0];
    }
    
    if(_refreshView){
        [_refreshView setDelegate:self];
        [_refreshView setDataSource:self];
        [_refreshView setListCallBackDelegate:self];
    }
    return _refreshView;
 }

- (void) listViewDidTriggerRefresh:(UIScrollView *) listView{
    if(![self bRefreshing]){
        [self setBRefreshing:YES];
        [self setBLoading:YES];
        [self refreshStatusView];
        
        [self refreshToDown:listView];
    }
}

- (void) listViewDidTriggerLoadMore:(UIScrollView *) listView{
    if(![self bRefreshing]){
        [self setBRefreshing:YES];
        [self setBLoading:YES];
        [self refreshStatusView];

        [self loadToMore:listView];
    }
}

- (void) initView{
    if(_refreshView){
        [_refreshView setHeadView:[self loadHeadView]];
        [_refreshView setFootView:[self loadFootView]];
        [_refreshView setListStyle:[self getListStyle]];
    }
}

- (void) loadPage{
    
}

- (XBaseListViewStyle) getListStyle{
    return XBaseListViewStyleNone;
}

- (XBaseListHeadView *) loadHeadView{
    return nil;
}

- (XBaseListFootView *) loadFootView{
    return nil;
}

- (void) refreshToDown:(UIScrollView *) scrollView{
    
}

- (void) refreshFinish:(NSArray *) dataList bError:(BOOL) bError{
    if(bError){
        [self setBError:YES];
    }else{
        if([dataList count] > 0){
            [self setBIgnoreShowError:YES];
            [self setBNotData:NO];
        }else{
            [self setBNotData:YES];
            
        }
    }
    [self setBRefreshing:NO];
    [self setBLoading:NO];
    [self refreshStatusView];
    [_refreshView finishLoad];
}

- (void) loadToMore:(UIScrollView *) scrollView{
    
}

- (void) loadFinish:(NSArray *) dataList bError:(BOOL) bError{
    if(!bError){
        if([dataList count] > 0){
            
        }
    }
    
    [self setBRefreshing:NO];
    [self setBLoading:NO];
    [self refreshStatusView];
    [_refreshView finishLoad];
}

- (void) setBAutoLoading:(BOOL) bAutoLoading{
    [_refreshView setBAutoLoading:bAutoLoading];
}

- (void) setBPreLoadMore:(BOOL) bPreLoadMore{
    [_refreshView setBPreLoadMore:bPreLoadMore];
}

#pragma mark --
#pragma mark UITableViewDelegate

#pragma mark --
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
