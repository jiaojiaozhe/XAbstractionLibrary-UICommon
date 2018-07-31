//
//  TabBarItem.m
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/31.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import "TabBarItem.h"

@interface TabBarItem()
@property (nonatomic,weak) id target;
@property (nonatomic,assign) SEL action;
@property (nonatomic,strong) IBOutlet UIButton *clickBtn;
@property (nonatomic,strong) IBOutlet UILabel *itemLabel;
@end

@implementation TabBarItem

- (IBAction) tabBarItemClick:(id) sender{
    if([_target respondsToSelector:_action]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_action withObject:self];
#pragma clang diagnostic pop
    }
}

- (void) setItemText:(NSString *) itemText{
    self.itemLabel.text = itemText;
}

- (void) addTarget:(id)target action:(SEL)action{
    _target = target;
    _action = action;
}

@end
