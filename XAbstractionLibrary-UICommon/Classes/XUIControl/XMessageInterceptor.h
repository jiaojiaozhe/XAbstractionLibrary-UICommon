//
//  XMessageInterceptor.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <XAbstractionLibrary_Parse/XAbstractionLibrary-Parse-umbrella.h>

@interface XMessageInterceptor : XBaseModel
@property (nonatomic,weak) id interceptor;

@property (nonatomic,weak) id delegateReceiver;

@property (nonatomic,weak) id dataSourceReceiver;
@end
