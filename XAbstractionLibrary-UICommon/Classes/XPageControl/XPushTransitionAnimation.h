//
//  XPushTransitionAnimation.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/31.
//

#import <Foundation/Foundation.h>

typedef enum {
    //push
    PushTransitionAnimationTypePush,
    //pop
    PushTransitionAnimationTypePop,
} PushTransitionAnimationType;


@interface XPushTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) PushTransitionAnimationType type;
@end
