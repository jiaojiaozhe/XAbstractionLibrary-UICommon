//
//  XRefreshView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/8/9.
//

#import "XTableView.h"
#import "XRefreshView.h"

@interface XRefreshView()
@property (nonatomic,strong) IBOutlet XTableView *tableView;
@end

@implementation XRefreshView
- (instancetype) init{
    if(self = [super init]){
        [self initControl];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self initControl];
    }
    return self;
}

- (void) awakeFromNib{
    [super awakeFromNib];
    [self initControl];
}

- (void) initControl{
    if(@available(iOS 11.3, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (XTableView *) tableView{
    if(!_tableView){
        _tableView = [[XTableView alloc] init];
    }
    return _tableView;
}

- (void) setHeadView:(XListHeadView *) headView{
    [self.tableView setHeadView:headView];
}

- (void) setFootView:(XListFootView *) footView{
    [self.tableView setFootView:footView];
}

- (void) setListStyle:(XListViewStyle) listStyle{
    [self.tableView setListStyle:listStyle];
}

- (void) setDelegate:(id<UITableViewDelegate>) delegate{
    [self.tableView setDelegate:delegate];
}

- (void) setDataSource:(id<UITableViewDataSource>) dataSource{
    [self.tableView setDataSource:dataSource];
}

- (void) setListCallBackDelegate:(id<XListCallBackDelegate>) callBackDelegate{
    [self.tableView setCallBackDelegate:callBackDelegate];
}

- (void) finishLoad{
    [self.tableView finishLoad];
    [self.tableView reloadData];
}

- (void) setBAutoLoading:(BOOL) bAutoLoading{
    [self.tableView setBAutoLoading:bAutoLoading];
}

- (void) setBPreLoadMore:(BOOL) bPreLoadMore{
    [self.tableView setBPreLoad:bPreLoadMore];
}
@end
