//
//  XRefreshView.m
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/8/9.
//

#import "XBaseTableView.h"
#import "XRefreshView.h"

@interface XRefreshView()
@property (nonatomic,strong) IBOutlet XBaseTableView *tableView;
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
    if(@available(iOS 11.0, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (XBaseTableView *) tableView{
    if(!_tableView){
        _tableView = [[XBaseTableView alloc] init];
    }
    return _tableView;
}

- (void) setHeadView:(XBaseListHeadView *) headView{
    [self.tableView setHeadView:headView];
}

- (void) setFootView:(XBaseListFootView *) footView{
    [self.tableView setFootView:footView];
}

- (void) setListStyle:(XBaseListViewStyle) listStyle{
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
