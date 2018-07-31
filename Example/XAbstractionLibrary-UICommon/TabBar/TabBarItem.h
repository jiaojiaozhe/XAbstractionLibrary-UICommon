//
//  TabBarItem.h
//  XAbstractionLibrary-UICommon_Example
//
//  Created by lanbiao on 2018/7/31.
//  Copyright © 2018年 jiaojiaozhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XXNibBridge/XXNibBridge-umbrella.h>

typedef NS_ENUM(NSInteger, TabBarItemTag){
    TabBarItemTagOne,
    TabBarItemTagTow,
    TabBarItemTagThree,
    TabBarItemTagFour,
    TabBarItemTagFive,
};

@interface TabBarItem : UIView<XXNibBridge>
@property (nonatomic,assign) TabBarItemTag itemTag;

- (void) setItemText:(NSString *) itemText;
- (void) addTarget:(id)target action:(SEL)action;
@end
