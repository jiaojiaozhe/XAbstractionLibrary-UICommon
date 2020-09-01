//
//  XHeadView.m
//  AIParkSJZ
//
//  Created by lanbiao on 2018/8/16.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "XHeadView.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

@interface XHeadView()
@property (nonatomic,strong) IBOutlet UIView *leftView;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *leftWidthConstraint;
@property (nonatomic,strong) IBOutlet UIView *centerView;
@property (nonatomic,strong) IBOutlet UIView *rightView;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *rightWidthConstraint;
@property (nonatomic,strong) IBOutlet UIView *lineView;


@property (nonatomic,strong) IBOutlet NSLayoutConstraint *leftTopConstraint;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *leftHeightConstraint;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *centerTopConstraint;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *centerHeightConstraint;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *rightTopContraint;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *rightHeightContraint;
@end

@implementation XHeadView

+ (XHeadView *) createHeadViewWithDelegate:(id<XHeadViewDelegate>) delegate{
    Class class = [XHeadView class];
    NSString *className = NSStringFromClass(class);
    NSBundle *frameWorkBundle = [NSBundle bundleForClass: class];
    NSString *projectName = [[[[frameWorkBundle bundlePath] lastPathComponent] stringByDeletingPathExtension] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
    NSString *frameWorkBundlePath = [frameWorkBundle pathForResource:projectName
                                                              ofType:@"bundle"];
    NSBundle *xibBundle = [NSBundle bundleWithPath:frameWorkBundlePath];
    
    XHeadView *headView = [[xibBundle loadNibNamed:className
                                                      owner:nil
                                                    options:nil] firstObject];
    
    headView.delegate = delegate;
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat headerTop = statusRect.size.height;
    CGFloat headViewHeight = VIEW_HEIGHT(headView);
    SET_VIEW_HEIGHT(headView, headerTop + headViewHeight);
    [headView setLeftView];
    [headView setRightView];
    [headView setCenterView];
    return headView;
}

- (void) setLeftView{
    
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat headerTop = statusRect.size.height;
    _leftTopConstraint.constant = headerTop;
    _leftHeightConstraint.constant = - headerTop;
//    [self.leftView setNeedsLayout];
//    [self.leftView layoutIfNeeded];
    
    UIView *leftContentView = [self getHeadLeftView];
    if(leftContentView){
        [self.leftView addSubview:leftContentView];
        CGFloat widthConstraint = VIEW_WIDTH(leftContentView);
        _leftWidthConstraint.constant = widthConstraint;
        
        leftContentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:leftContentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.leftView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0];
        [self.leftView addConstraint:leftConstraint];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:leftContentView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.leftView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:0.0];
        [self.leftView addConstraint:topConstraint];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:leftContentView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.leftView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0.0];
        [self.leftView addConstraint:rightConstraint];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:leftContentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.leftView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0
                                                                             constant:0.0];
        [self.leftView addConstraint:bottomConstraint];
        [leftContentView setNeedsLayout];
        [leftContentView layoutIfNeeded];
    }else{
        _leftWidthConstraint.constant = 0;
    }
}

- (void) setRightView{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat headerTop = statusRect.size.height;
    _rightTopContraint.constant = headerTop;
    _rightHeightContraint.constant = - headerTop;
//    [self.rightView setNeedsLayout];
//    [self.rightView layoutIfNeeded];
    
    UIView *rightContentView = [self getHeadRightView];
    if(rightContentView){
        [self.rightView addSubview:rightContentView];
        CGFloat widthConstraint = VIEW_WIDTH(rightContentView);
        _rightWidthConstraint.constant = widthConstraint;
        
        rightContentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:rightContentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.rightView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1.0
                                                                           constant:0.0];
        [self.rightView addConstraint:leftConstraint];
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:rightContentView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.rightView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:0.0];
        [self.rightView addConstraint:topConstraint];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:rightContentView
                                                                           attribute:NSLayoutAttributeRight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.rightView
                                                                           attribute:NSLayoutAttributeRight
                                                                          multiplier:1.0
                                                                            constant:0.0];
        [self.rightView addConstraint:rightConstraint];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:rightContentView
                                                                            attribute:NSLayoutAttributeBottom
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.rightView
                                                                            attribute:NSLayoutAttributeBottom
                                                                           multiplier:1.0
                                                                             constant:0.0];
        [self.rightView addConstraint:bottomConstraint];
        [rightContentView setNeedsLayout];
        [rightContentView layoutIfNeeded];
    }else{
        _rightWidthConstraint.constant = 0;
    }
}

- (void) setCenterView{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat headerTop = statusRect.size.height;
    _centerTopConstraint.constant = headerTop;
    _centerHeightConstraint.constant = - headerTop;
//    [self.centerView setNeedsLayout];
//    [self.centerView layoutIfNeeded];
    
    UIView *centerContentView = [self getHeadCenterView];
    if(centerContentView){
        [self.centerView addSubview:centerContentView];
        
        centerContentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *xCenterConstraint = [NSLayoutConstraint constraintWithItem:centerContentView
                                                                          attribute:NSLayoutAttributeCenterX
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.centerView
                                                                          attribute:NSLayoutAttributeCenterX
                                                                         multiplier:1.0
                                                                           constant:0.0];
        [self.centerView addConstraint:xCenterConstraint];
        NSLayoutConstraint *yCenterConstraint = [NSLayoutConstraint constraintWithItem:centerContentView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.centerView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0.0];
        [self.centerView addConstraint:yCenterConstraint];
        
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:centerContentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationLessThanOrEqual
                                                                              toItem:self.centerView
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.0
                                                                            constant:0];
        widthConstraint.priority = UILayoutPriorityDefaultLow;
        [self.centerView addConstraint:widthConstraint];
        
        NSLayoutConstraint *widthConstraint2 = [NSLayoutConstraint constraintWithItem:centerContentView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                             constant:VIEW_WIDTH(centerContentView)];
        widthConstraint2.priority = UILayoutPriorityFittingSizeLevel;
        [self.centerView addConstraint:widthConstraint2];
        
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:centerContentView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:VIEW_HEIGHT(centerContentView)];
        [self.centerView addConstraint:heightConstraint];
        [centerContentView setNeedsLayout];
        [centerContentView layoutIfNeeded];
    }
}

- (UIView *) getHeadLeftView{
    UIView *leftView = nil;
    if(_delegate &&
       [_delegate respondsToSelector:@selector(getHeadLeftView)]){
        leftView = [_delegate getHeadLeftView];
    }
    return leftView;
}

- (UIView *) getHeadRightView{
    UIView *rightView = nil;
    if(_delegate &&
       [_delegate respondsToSelector:@selector(getHeadRightView)]){
        rightView = [_delegate getHeadRightView];
    }
    
    return rightView;
}

- (UIView *) getHeadCenterView{
    UIView *centerView = nil;
    if(_delegate &&
       [_delegate respondsToSelector:@selector(getHeadCenterView)]){
        centerView = [_delegate getHeadCenterView];
    }
    return centerView;
}

- (void) setShowLine:(BOOL) bShow{
    [self.lineView setHidden:!bShow];
}

- (void) setLineColor:(UIColor *) color{
    [self.lineView setBackgroundColor:color];
}

@end
