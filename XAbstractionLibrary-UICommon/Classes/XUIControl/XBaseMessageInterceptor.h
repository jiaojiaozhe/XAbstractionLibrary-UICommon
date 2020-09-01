//
//  XBaseMessageInterceptor.h
//  XAbstractionLibrary-UICommon
//
//  Created by lanbiao on 2018/7/16.
//

#import <XAbstractionLibrary_Parse/XAbstractionLibrary-Parse-umbrella.h>

@interface XBaseMessageInterceptor : XBaseModel
@property (nonatomic,weak) id interceptor;

@property (nonatomic,weak) id delegateReceiver;

@property (nonatomic,weak) id dataSourceReceiver;
@end
