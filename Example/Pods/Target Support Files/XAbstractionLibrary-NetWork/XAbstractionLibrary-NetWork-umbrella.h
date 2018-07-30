#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XDownloadHttpRequest.h"
#import "XHttpRequest.h"
#import "XHttpRequestDelegate.h"
#import "XHttpRequestManager.h"
#import "XHttpResponseDelegate.h"
#import "XNetWorkStatus.h"
#import "XUploadHttpRequest.h"

FOUNDATION_EXPORT double XAbstractionLibrary_NetWorkVersionNumber;
FOUNDATION_EXPORT const unsigned char XAbstractionLibrary_NetWorkVersionString[];

