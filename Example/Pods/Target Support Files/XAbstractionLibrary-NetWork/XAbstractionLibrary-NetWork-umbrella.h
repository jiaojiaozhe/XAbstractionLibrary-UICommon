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

#import "XBaseDownloadHttpRequest.h"
#import "XBaseHttpRequest.h"
#import "XBaseHttpRequestManager.h"
#import "XBaseUploadHttpRequest.h"
#import "XHttpRequestDelegate.h"
#import "XHttpResponseDelegate.h"
#import "XNetWorkStatus.h"

FOUNDATION_EXPORT double XAbstractionLibrary_NetWorkVersionNumber;
FOUNDATION_EXPORT const unsigned char XAbstractionLibrary_NetWorkVersionString[];

