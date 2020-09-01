//
//  XBaseHttpRequestManager.h
//  AFNetworking
//
//  Created by lanbiao on 2018/7/12.
//

#import "XHttpRequestDelegate.h"
#import "XHttpResponseDelegate.h"
#import <XAbstractionLibrary_Base/XAbstractionLibrary-Base-umbrella.h>

typedef NS_ENUM(NSInteger, RequestSerializerType) {
    RequestSerializerTypeUnknown        = -1,
    RequestSerializerTypeHTTP           = 0,
    RequestSerializerTypeJSON           = 1,
    RequestSerializerTypePropertyList   = 2,
};

typedef NS_ENUM(NSInteger, ResponseSerializerType) {
    ResponseSerializerTypeUnknown        = -1,
    ResponseSerializerTypeHTTP           = 0,
    ResponseSerializerTypeJSON           = 1,
    ResponseSerializerTypePropertyList   = 2,
    ResponseSerializerTypeXMLParse       = 3,
    ResponseSerializerTypeImage          = 4,
};

/**
 *  http请求管理器
 */
@interface XBaseHttpRequestManager : XData

/**
 *  请求的超时时间设置
 */
- (NSTimeInterval) timeOut;

/**
 *  设置请求格式
 */
- (RequestSerializerType) getRequestSerializerType;

/**
 *  设置返回格式
 */
- (ResponseSerializerType) getResponseSerializerType;

/**
 *  设置返回格式支持协议类型
 **/
- (NSSet*) getAcceptableContentTypes;

/**
 *  get请求
 *
 *  @param requestUrlString     接口请求url
 *  @param requestParams        接口请求参数集合
 *  @param delegate             接口请求回调代理
 *  @param responseblock        接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                       requestParams:(NSDictionary *) requestParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 *  get请求,公共参数放在header中
 *
 *  @param requestUrlString     接口请求url
 *  @param requestParams        接口请求私有参数集合
 *  @param requestHeaderParams  接口共有参数集合
 *  @param delegate             接口请求回调代理
 *  @param responseblock        接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                       requestParams:(NSDictionary *) requestParams
                                 requestHeaderParams:(NSDictionary *) requestHeaderParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;

/**
 *  post请求
 *
 *  @param postUrlString    接口请求url
 *  @param postParams       接口请求参数集合
 *  @param delegate         接口请求代理
 *  @param responseblock    接口请求业务回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithUrlString:(NSString *) postUrlString
                                           postParams:(NSDictionary *) postParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;

/**
 *  post请求，公共参数放在header中
 *
 *  @param postUrlString            接口请求url
 *  @param postParams               接口请求参数集合
 *  @param postHeaderParams         接口请求header集合
 *  @param delegate                 接口请求代理
 *  @param responseblock            接口请求业务回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithUrlString:(NSString *) postUrlString
                                           postParams:(NSDictionary *) postParams
                                     postHeaderParams:(NSDictionary *) postHeaderParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 delete请求

 @param deleteUrlString 接口请求url
 @param deleteParams 接口请求参数集合
 @param delegate 接口请求状态回调代理
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) deleteRequestWithUrlString:(NSString *) deleteUrlString
                                           deleteParams:(NSDictionary *) deleteParams
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 delete请求

 @param deleteUrlString 接口请求url
 @param deleteParams 接口请求参数集合
 @param deleteRequestHeader 接口请求header集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) deleteRequestWithUrlString:(NSString *) deleteUrlString
                                           deleteParams:(NSDictionary *) deleteParams
                                    deleteRequestHeader:(NSDictionary *) deleteRequestHeader
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 head请求

 @param headUrlString 接口请求url
 @param headParams 接口请求参数集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) headRequestWithUrlString:(NSString *) headUrlString
                                           headParams:(NSDictionary *) headParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 head请求

 @param headUrlString 接口请求url
 @param headParams 接口请求参数集合
 @param headRequestHeader 接口请求header参数集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) headRequestWithUrlString:(NSString *) headUrlString
                                           headParams:(NSDictionary *) headParams
                                    headRequestHeader:(NSDictionary *) headRequestHeader
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 put请求

 @param putUrlString 接口请求url
 @param putParams 接口请求参数集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) putRequestWithUrlString:(NSString *) putUrlString
                                           putParams:(NSDictionary *) putParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 put请求

 @param putUrlString 接口请求url
 @param putParams 接口请求参数集合
 @param putRequestHeader 接口请求header参数集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) putRequestWithUrlString:(NSString *) putUrlString
                                           putParams:(NSDictionary *) putParams
                                    putRequestHeader:(NSDictionary *) putRequestHeader
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 patch请求

 @param patchUrlString 接口请求url
 @param patchParams 接口请求参数集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) patchRequestWithUrlString:(NSString *) patchUrlString
                                           patchParams:(NSDictionary *) patchParams
                                          httpDelegate:(id<XHttpResponseDelegate>) delegate
                                         responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 patch请求

 @param patchUrlString 接口请求对象
 @param patchParams 接口请求参数集合
 @param patchRequestHeader 接口请求header参数集合
 @param delegate 接口请求状态回调
 @param responseblock 接口请求业务回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) patchRequestWithUrlString:(NSString *) patchUrlString
                                           patchParams:(NSDictionary *) patchParams
                                    patchRequestHeader:(NSDictionary *) patchRequestHeader
                                          httpDelegate:(id<XHttpResponseDelegate>) delegate
                                         responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 *  上传文件
 *
 *  @param uploadUrlString          接口请求url
 *  @param uploadParameters         接口请求参数集合
 *  @param filePath                 待上传的文件路径
 *  @param delegate                 接口请求代理
 *  @param responseblock            接口请求回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) uploadRequestWithUrlString:(NSString *) uploadUrlString
                                       uploadParameters:(NSDictionary *) uploadParameters
                                         uploadFilePath:(NSString *) filePath
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 上传文件

 @param uploadUrlString 接口请求url
 @param uploadParameters 接口请求参数集合
 @param uploadRequestHeader 接口请求头参数集合
 @param filePath 待上传的文件路径
 @param delegate 接口请求代理
 @param responseblock 接口请求回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) uploadRequestWithUrlString:(NSString *) uploadUrlString
                                       uploadParameters:(NSDictionary *) uploadParameters
                                    uploadRequestHeader:(NSDictionary *) uploadRequestHeader
                                         uploadFilePath:(NSString *) filePath
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;

/**
 *  下载文件
 *
 *  @param downloadUrlString            接口请求url
 *  @param downloadParameters           接口请求参数集合
 *  @param saveFilePath                 下载保存文件路径
 *  @param delegate                     接口请求代理
 *  @param responseblock                接口请求回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) downloadRequestWithUrlString:(NSString *) downloadUrlString
                                       downloadParameters:(NSDictionary *) downloadParameters
                                             saveFilePath:(NSString *) saveFilePath
                                             httpDelegate:(id<XHttpResponseDelegate>) delegate
                                            responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;


/**
 下载文件

 @param downloadUrlString 接口请求url
 @param downloadParameters 接口请求参数集合
 @param downloadRequestHeader 接口请求头集合
 @param saveFilePath 下载保存文件路径
 @param delegate 接口请求代理
 @param responseblock 接口请求回调
 @return 请求对象
 */
- (id<XHttpRequestDelegate>) downloadRequestWithUrlString:(NSString *) downloadUrlString
                                       downloadParameters:(NSDictionary *) downloadParameters
                                    downloadRequestHeader:(NSDictionary *) downloadRequestHeader
                                             saveFilePath:(NSString *) saveFilePath
                                             httpDelegate:(id<XHttpResponseDelegate>) delegate
                                            responseblock:(XResponseBlock) responseblock DEPRECATED_ATTRIBUTE;

@end
