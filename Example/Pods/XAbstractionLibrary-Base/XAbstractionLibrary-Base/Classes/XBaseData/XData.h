//
//  XData.h
//  MD5Digest
//
//  Created by lanbiao on 2018/7/13.
//

#import <Foundation/Foundation.h>

@interface XData : NSObject

/**
 *  对象ID
 */
@property (nonatomic,strong) NSString *ID;

/**
 *  确保本地每个数据源、任务等有本地唯一的ID,继承自XData的对象都会自动调用处理
 *
 *  @return 返回一个唯一的ID
 */
+ (NSString *) uuid;

/**
 *  验证对象ID是否存在
 *
 *  @return YES 存在 NO 不存在
 */
- (BOOL) validateID;

/**
 *  预埋，未来添加的事情
 */
+ (BOOL) validity;

@end
