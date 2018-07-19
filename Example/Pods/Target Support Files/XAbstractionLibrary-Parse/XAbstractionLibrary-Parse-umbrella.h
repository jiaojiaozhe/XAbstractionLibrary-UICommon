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

#import "XBaseModel.h"
#import "XResult.h"
#import "NSValueTransformer+CustomParseDictionary.h"
#import "NSValueTransformer+CustomParseNSArray.h"
#import "XJSONAdapter.h"
#import "XMantle.h"
#import "XModel.h"
#import "XArrayTypeValidator.h"
#import "XBaseValidator.h"
#import "XBooleanTypeValidator.h"
#import "XCharTypeValidator.h"
#import "XCompositeTypeValidator.h"
#import "XDataTypeValidator.h"
#import "XDateTypeValidator.h"
#import "XDefaultValue.h"
#import "XDictionaryTypeValidator.h"
#import "XDoubleTypeValidator.h"
#import "XFloatTypeValidator.h"
#import "XIntergerTypeValidator.h"
#import "XIntTypeValidator.h"
#import "XMutableArrayTypeValidator.h"
#import "XMutableDictionaryTypeValidator.h"
#import "XMutableStringTypeValidator.h"
#import "XNumberTypeValidator.h"
#import "XStringTypeValidator.h"
#import "XUnknowTypeValidator.h"
#import "XUnsignedCharTypeValidator.h"
#import "XUnsignedIntegerTypeValidator.h"

FOUNDATION_EXPORT double XAbstractionLibrary_ParseVersionNumber;
FOUNDATION_EXPORT const unsigned char XAbstractionLibrary_ParseVersionString[];

