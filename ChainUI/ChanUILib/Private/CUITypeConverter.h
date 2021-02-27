//
//  CUITypeConverter.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <objc/objc.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "CUIDefs.h"


#define CUI_CONVERT_VALUE_TO_STRING(x)  CUIConvertValueToString(CUI_TYPE(x), x)
#define CUI_CONVERT_VALUE_TO_NUMBER(x)  CUIConvertValueToNumber(CUI_TYPE(x), x)

#define CUI_IS_STRING(x)                (CUI_IS_OBJECT(x) && CUIObjectIsKindOfClass(@"NSString", x))
#define CUI_CHECK_IS_STRING(x, ...)     CUI_IS_STRING(x)

#define CUI_IS_ATT_STRING(x)            (CUI_IS_OBJECT(x) && CUIObjectIsKindOfClass(@"NSAttributedString", x))
#define CUI_CHECK_IS_ATT_STRING(x, ...) CUI_IS_ATT_STRING(x)

#define CUI_RETURN_OBJECT(x, ...)       CUIObjectFromVariadicFunction(@"placeholder", x)

#define CUI_STRING_VALUE(x, ...)        ({ typeof(x) _ix_ = (x); CUIStringRepresentationOfValue(@encode(typeof(x)), &_ix_); })
#define CUI_STRING_FORMAT(...)          ({ CUIFormatedStringWithArgumentsCount(CUI_NUMBER_OF_VA_ARGS(__VA_ARGS__), __VA_ARGS__); })

#define CUI_LOG_PREFIX(x, ...)          ({ const char *_exp_ = #x; _exp_[strlen(_exp_) - 1] == '"'? @"": [NSString stringWithFormat:@"%s: ", _exp_]; })

#define CUI_NORMALIZE_INSETS(...)       CUIConvertCUIEdgeInsetsToUIEdgeInsets((CUIEdgeInsets){__VA_ARGS__}, CUI_NUMBER_OF_VA_ARGS(__VA_ARGS__))


id      CUIConvertValueToString(const char *type, ...);
id      CUIConvertValueToNumber(const char *type, ...);
id      CUIObjectFromVariadicFunction(NSString *placeholder, ...);
BOOL    CUIObjectIsKindOfClass(NSString *className, ...);

NSString *      CUIFormatedStringWithArgumentsCount(NSInteger count, ...);
UIEdgeInsets    CUIConvertCUIEdgeInsetsToUIEdgeInsets(CUIEdgeInsets insets, NSInteger number);
NSString *      CUIStringRepresentationOfValue(const char *type, const void *value);


