//
//  NSString+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <Foundation/Foundation.h>
#import "CUIDefs.h"
#import "CUITypeConverter.h"

/**
 * Create a NSString.
 * Str argument can be:
   1) C string
   2) any primitive type
   3) any object
   4) CGRect, CGPoint, CGSize, NSRange, UIEdgeInsets
   5) Selector
   6) Class
   7) Format String
 
 * Usages: Str(100), Str(3.14), Str(@0.618), Str([UIView class]), Str(_cmd), Str(view.frame),
           Str("Hello"), Str(@"World"), Str(@"%d+%d=%d", 1, 1, 1 + 1)
 */
#define Str(...)                ({CUI_CHECK_IS_STRING(__VA_ARGS__)? \
                                    CUI_STRING_FORMAT(__VA_ARGS__):\
                                    CUI_STRING_VALUE(__VA_ARGS__);})

#define DebugStr(...)                ({id _prefix_ = CUI_LOG_PREFIX(__VA_ARGS__); \
                                    id _str_ = Str(__VA_ARGS__);\
                                    Str(@"%@%@", _prefix_, _str_);})

#define DebugStrN(...)              DebugStr(__VA_ARGS__).a(@"\n")
/**
 * Logging a single value or Logging with format string.
 * Log use Str() internally, so it can take any kind of arguments that Str() supported.
 * Usages: Log(view.height), Log(view.frame), Log(view), Log(_cmd),
           Log("Hello"), Log(@"World"), Log(@"%d+%d=%d", 1, 1, 1 + 1)
 */
#ifndef __OPTIMIZE__
#define Log(...)                ({id _prefix_ = CUI_LOG_PREFIX(__VA_ARGS__); \
                                    id _str_ = Str(__VA_ARGS__);\
                                    NSLog(@"%@%@", _prefix_, _str_);})
#else
#define Log(...)
#endif


/**
 * Create an NSURL from URL string.
 */
#define Url(s)                  [NSURL URLWithString:s]

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Chainable)

/**
 * Appending string.
 * a use Str() internally, so it can take any kind of arguments that Str() supported.
 * Usages: @"1".a(@"2").a(3).a(nil).a(4.0f).a(@5).a(@"%d", 6);      //@"123456"
 */
CUI_STRING_PROP(Object)         a;

/**
 * Appending path component.
 * ap use Str() internally, so it can take any kind of arguments that Str() supported.
 * Usages: @"dir1".ap(222).ap(@"dir3").ap(@"cat.png")               //@"dir1/222/dir3/cat.png"
 */
CUI_STRING_PROP(Object)         ap;

/**
 * Substring from index or from substring.
 * Usages:
   @"hello".subFrom(2);             //@"llo"
   @"hello".subFrom(@"el");         //@"ello"
 */
CUI_STRING_PROP(IntOrObject)    subFrom;

/**
 * Substring to index or to substring.
 * Usages:
   @"hello".subTo(2);               //@"he"
   @"hello".subTo(@"el");           //@"h"
   @"hello".subFrom(1).subTo(@"o"); //@"ell"
 */
CUI_STRING_PROP(IntOrObject)    subTo;

/**
 * Return first substring that match the regular expression.
 * It support two kind of argument:
   1) NSRegularExpression
   2) NSString that represent regular expression pattern.
 * Usages: @"pi: 3.14".subMatch(@"[0-9.]+")         //@"3.14"
 */
CUI_STRING_PROP(Object)         subMatch;

/**
 * Returns a new string containing matching regular expressions replaced with the template string.
 * Inside template string, $0 being replaced by the contents of the matched range,
   $1 by the contents of the first capture group, and so on.
 * Usages:
   @"hello world".subReplace(@"world", @"WORLD")                //@"hello WORLD"
   @"hello world".subReplace(@"(\\w+) (\\w+)", @"$2 $1")        //@"world hello"
 */
CUI_STRING_PROP(TwoObject)      subReplace;


#define a(...)                  a(Str(__VA_ARGS__))
#define ap(...)                 ap(Str(__VA_ARGS__))
#define subFrom(x)              subFrom(CUI_CONVERT_VALUE_TO_NUMBER(x))
#define subTo(x)                subTo(CUI_CONVERT_VALUE_TO_NUMBER(x))


/**
 * Prepend document/caches/tmp directory path to current string.
 * Usages: @"abc.db".inCaches, @"images".ap("cat.png").inDocument
 */
- (NSString *)inDocument;
- (NSString *)inCaches;
- (NSString *)inTmp;

@end

NS_ASSUME_NONNULL_END
