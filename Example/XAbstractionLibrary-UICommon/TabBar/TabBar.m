//
//  TabBar.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/30.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "TabBar.h"
#import "TabBarItem.h"

@interface TabBar ()
@property (nonatomic,strong) IBOutlet TabBarItem *tabBarItem1;
@property (nonatomic,strong) IBOutlet TabBarItem *tabBarItem2;
@property (nonatomic,strong) IBOutlet TabBarItem *tabBarItem3;
@property (nonatomic,strong) IBOutlet TabBarItem *tabBarItem4;
@property (nonatomic,strong) IBOutlet TabBarItem *tabBarItem5;
@end

@implementation TabBar

+ (TabBar *) createTabBar
{
    TabBar *tabBar = [[[NSBundle mainBundle] loadNibNamed:@"TabBar" owner:self options:nil] objectAtIndex:0];
    return tabBar;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [_tabBarItem1 setItemText:@"1"];
    _tabBarItem1.itemTag = TabBarItemTagOne;
    
    [_tabBarItem2 setItemText:@"2"];
    _tabBarItem2.itemTag = TabBarItemTagTow;
    
    [_tabBarItem3 setItemText:@"3"];
    _tabBarItem3.itemTag = TabBarItemTagThree;
    
    [_tabBarItem4 setItemText:@"4"];
    _tabBarItem4.itemTag = TabBarItemTagFour;
    
    [_tabBarItem5 setItemText:@"5"];
    _tabBarItem5.itemTag = TabBarItemTagFive;
}

- (void) addTarget:(id)target action:(SEL)action
{
    [_tabBarItem1 addTarget:target action:action];
    [_tabBarItem2 addTarget:target action:action];
    [_tabBarItem3 addTarget:target action:action];
    [_tabBarItem4 addTarget:target action:action];
    [_tabBarItem5 addTarget:target action:action];
}

@end
