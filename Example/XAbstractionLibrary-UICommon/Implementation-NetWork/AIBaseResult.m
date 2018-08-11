//
//  AIBaseResult.m
//  AiParkToC
//
//  Created by lanbiao on 2018/8/1.
//  Copyright © 2018年 lanbiao. All rights reserved.
//

#import "AIErrorCode.h"
#import "AIBaseResult.h"

@implementation AIBaseResult

+ (NSDictionary *) JSONKeyPathsByPropertyKey{
    NSMutableDictionary *keys = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    keys[@"errorCode"] = @"code";
    keys[@"serverMsg"] = @"msg";
    return keys;
}

+ (AIBaseResult *) createResultWithErrorCode:(NSInteger) errorCode
                                   serverMsg:(NSString *) serverMsg{
    AIBaseResult *result = [[AIBaseResult alloc] init];
    [result setErrorCode:errorCode];
    [result setServerMsg:serverMsg];
    return result;
}

+ (AIBaseResult *) createSuccess{
    return [AIBaseResult createResultWithErrorCode:AI_REQUEST_SUCCESS serverMsg:@"请求成功."];
}

+ (AIBaseResult *) createTimerout{
    return [AIBaseResult createResultWithErrorCode:AI_REQUEST_TIMEROUT serverMsg:@"请求超时."];
}

+ (AIBaseResult *) createOtherError{
    return [AIBaseResult createResultWithErrorCode:AI_REQUEST_OTHER_ERROR serverMsg:@"请求发生未知错误."];
}

- (BOOL) isSuccess{
    return _errorCode == AI_REQUEST_SUCCESS;
}

- (NSString*) getServerMsg{
    return _serverMsg;
}

@end
