//
//  ChainUIDefines.h
//  Demo
//
//  Created by Joe.cheng on 2021/2/25.
//



#import <objc/objc.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

typedef struct CUIRect {
    CGRect value;
} CUIRect;

typedef struct CUIPoint {
    CGPoint value;
} CUIPoint;

typedef struct CUISize {
    CGSize value;
} CUISize;

typedef struct CUIEdgeInsets {
    UIEdgeInsets value;
} CUIEdgeInsets;

typedef struct CUIRange {
    NSRange value;
} CUIRange;

typedef struct CUIFloatList {
    CGFloat f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;
    CGFloat validCount;
} CUIFloatList;

#define CUI_MAKE_FLOAT_LIST(...)    ({CUIFloatList floatList = (CUIFloatList){__VA_ARGS__}; \
                                    floatList.validCount = MIN(10, CUI_NUMBER_OF_VA_ARGS(__VA_ARGS__)); \
                                    floatList;})


typedef void (^CUISimpleBlock)();
typedef void (^CUIObjectBlock)(id);


#define CUINull             NSIntegerMax

#define Exp(x)              ({x;})

@class CUIConstraint;
@class CUIAlert;
@class CUIStack;
@class CUIStyle;
@class CUIStaticRow;
@class CUIStaticSection;
@class CUIStaticTableView;

/*
 Chainable properties
 */

#define CUI_READONLY                @property (nonatomic, readonly)

#define CUI_PROP(x,y)               CUI_READONLY CUIChainable##x##y##Block
#define CUI_CHAINABLE_TYPE(v, t)    typedef v *(^CUIChainable##v##t##Block)

#define CUI_LABEL_PROP(y)           CUI_PROP(UILabel, y)
#define CUI_BUTTON_PROP(y)          CUI_PROP(UIButton, y)
#define CUI_IV_PROP(y)              CUI_PROP(UIImageView, y)
#define CUI_TF_PROP(y)              CUI_PROP(UITextField, y)
#define CUI_TV_PROP(y)              CUI_PROP(UITextView, y)
#define CUI_SWITCH_PROP(y)          CUI_PROP(UISwitch, y)
#define CUI_PC_PROP(y)              CUI_PROP(UIPageControl, y)
#define CUI_SLIDER_PROP(y)          CUI_PROP(UISlider, y)
#define CUI_STEPPER_PROP(y)         CUI_PROP(UIStepper, y)
#define CUI_SEGMENTED_PROP(y)       CUI_PROP(UISegmentedControl, y)
#define CUI_EFFECT_PROP(y)          CUI_PROP(UIVisualEffectView, y)
#define CUI_IMG_PROP(y)             CUI_PROP(UIImage, y)
#define CUI_COLOR_PROP(y)           CUI_PROP(UIColor, y)
#define CUI_STRING_PROP(y)          CUI_PROP(NSString, y)
#define CUI_ATT_PROP(y)             CUI_PROP(NSMutableAttributedString, y)
#define CUI_CONSTRAINT_PROP(y)      CUI_PROP(CUIConstraint, y)
#define CUI_ALERT_PROP(y)           CUI_PROP(CUIAlert, y)
#define CUI_STACK_PROP(y)           CUI_PROP(CUIStack, y)
#define CUI_STYLE_PROP(y)           CUI_PROP(CUIStyle, y)
#define CUI_STATIC_PROP(y)          CUI_PROP(CUIStaticTableView, y)
#define CUI_SECTION_PROP(y)         CUI_PROP(CUIStaticSection, y)
#define CUI_ROW_PROP(y)             CUI_PROP(CUIStaticRow, y)

/*
 Chainable types
 */

#define CUI_GECUIATE_CHAINABLE_TYPES(x) \
CUI_CHAINABLE_TYPE(x, Empty)(void);\
CUI_CHAINABLE_TYPE(x, Object)(id);\
CUI_CHAINABLE_TYPE(x, TwoObject)(id, id);\
CUI_CHAINABLE_TYPE(x, ObjectList)(id, ...);\
CUI_CHAINABLE_TYPE(x, Bool)(NSInteger);\
CUI_CHAINABLE_TYPE(x, Int)(NSInteger);\
CUI_CHAINABLE_TYPE(x, TwoInt)(NSInteger, NSInteger);\
CUI_CHAINABLE_TYPE(x, IntOrObject)(id);\
CUI_CHAINABLE_TYPE(x, Float)(CGFloat);\
CUI_CHAINABLE_TYPE(x, TwoFloat)(CGFloat, CGFloat);\
CUI_CHAINABLE_TYPE(x, FourFloat)(CGFloat, CGFloat, CGFloat, CGFloat);\
CUI_CHAINABLE_TYPE(x, FloatList)(CUIFloatList);\
CUI_CHAINABLE_TYPE(x, FloatObjectList)(CGFloat, ...);\
CUI_CHAINABLE_TYPE(x, Rect)(CUIRect);\
CUI_CHAINABLE_TYPE(x, Size)(CUISize);\
CUI_CHAINABLE_TYPE(x, Point)(CUIPoint);\
CUI_CHAINABLE_TYPE(x, Range)(CUIRange);\
CUI_CHAINABLE_TYPE(x, Insets)(UIEdgeInsets);\
CUI_CHAINABLE_TYPE(x, Embed)(id, UIEdgeInsets);\
CUI_CHAINABLE_TYPE(x, Callback)(id, id);\
CUI_CHAINABLE_TYPE(x, Block)(id);

CUI_GECUIATE_CHAINABLE_TYPES(UIView);
CUI_GECUIATE_CHAINABLE_TYPES(UILabel);
CUI_GECUIATE_CHAINABLE_TYPES(UIImageView);
CUI_GECUIATE_CHAINABLE_TYPES(UIButton);
CUI_GECUIATE_CHAINABLE_TYPES(UITextField);
CUI_GECUIATE_CHAINABLE_TYPES(UITextView);
CUI_GECUIATE_CHAINABLE_TYPES(UISwitch);
CUI_GECUIATE_CHAINABLE_TYPES(UIPageControl);
CUI_GECUIATE_CHAINABLE_TYPES(UISlider);
CUI_GECUIATE_CHAINABLE_TYPES(UIStepper);
CUI_GECUIATE_CHAINABLE_TYPES(UISegmentedControl);
CUI_GECUIATE_CHAINABLE_TYPES(UIVisualEffectView);
CUI_GECUIATE_CHAINABLE_TYPES(UIImage);
CUI_GECUIATE_CHAINABLE_TYPES(UIColor);
CUI_GECUIATE_CHAINABLE_TYPES(NSString);
CUI_GECUIATE_CHAINABLE_TYPES(NSMutableAttributedString);
CUI_GECUIATE_CHAINABLE_TYPES(CUIConstraint);
CUI_GECUIATE_CHAINABLE_TYPES(CUIAlert);
CUI_GECUIATE_CHAINABLE_TYPES(CUIStack);
CUI_GECUIATE_CHAINABLE_TYPES(CUIStyle);
CUI_GECUIATE_CHAINABLE_TYPES(CUIStaticTableView);
CUI_GECUIATE_CHAINABLE_TYPES(CUIStaticRow);
CUI_GECUIATE_CHAINABLE_TYPES(CUIStaticSection);


#define CUI_CHAINABLE_BLOCK(x, ...) return ^(x value) {__VA_ARGS__; return self;}
#define CUI_EMPTY_BLOCK(...)        return ^{__VA_ARGS__; return self;}
#define CUI_OBJECT_BLOCK(...)       CUI_CHAINABLE_BLOCK(id, __VA_ARGS__)
#define CUI_INT_BLOCK(...)          CUI_CHAINABLE_BLOCK(NSInteger, __VA_ARGS__)
#define CUI_FLOAT_BLOCK(...)        CUI_CHAINABLE_BLOCK(CGFloat, __VA_ARGS__)
#define CUI_RANGE_BLOCK(...)        CUI_CHAINABLE_BLOCK(CUIRange, __VA_ARGS__)
#define CUI_POINT_BLOCK(...)        CUI_CHAINABLE_BLOCK(CUIPoint, __VA_ARGS__)
#define CUI_SIZE_BLOCK(...)         CUI_CHAINABLE_BLOCK(CUISize, __VA_ARGS__)
#define CUI_RECT_BLOCK(...)         CUI_CHAINABLE_BLOCK(CUIRect, __VA_ARGS__)
#define CUI_INSETS_BLOCK(...)       CUI_CHAINABLE_BLOCK(UIEdgeInsets, __VA_ARGS__)
#define CUI_FLOAT_LIST_BLOCK(...)   CUI_CHAINABLE_BLOCK(CUIFloatList, __VA_ARGS__)

#define CUI_TWO_INT_BLOCK(...)              return ^(NSInteger value1, NSInteger value2) {__VA_ARGS__; return self;}
#define CUI_TWO_FLOAT_BLOCK(...)            return ^(CGFloat value1, CGFloat value2) {__VA_ARGS__; return self;}
#define CUI_FLOAT_OBJECT_LIST_BLOCK(...)    return ^(CGFloat value, ...) {CUI_GET_VARIABLE_OBJECT_ARGUMENTS(value); __VA_ARGS__; return self;}

#define CUI_CALLBACK_BLOCK(...)     return ^(id target, id object) {__weak id weakTarget = target; __weak id weakSelf = self; __VA_ARGS__; weakTarget = nil; weakSelf = nil; return self;}



/*
 Introspect
 */
#define CUI_TYPE(x)                 @encode(typeof(x))
#define CUI_TYPE_FIRST_LETTER(x)    (CUI_TYPE(x)[0])
#define CUI_IS_TYPE_OF(x)           (strcmp(type, @encode(x)) == 0)

#define CUI_CHECK_IS_INT(x)         (strchr("liBLIcsqCSQ", x) != NULL)
#define CUI_CHECK_IS_FLOAT(x)       (strchr("df", x) != NULL)
#define CUI_CHECK_IS_PRIMITIVE(x)   (strchr("liBdfLIcsqCSQ", x) != NULL)
#define CUI_CHECK_IS_STRUCT_OF(x,y) ([[NSString stringWithUTF8String:x] rangeOfString:@#y].location == 1)
#define CUI_CHECK_IS_OBJECT(x)      (strchr("@#", x) != NULL)

#define CUI_IS_OBJECT(x)            (strchr("@#", CUI_TYPE_FIRST_LETTER(x)) != NULL)
#define CUI_IS_INT(x)               CUI_CHECK_IS_INT(CUI_TYPE_FIRST_LETTER(x))
#define CUI_IS_FLOAT(x)             CUI_CHECK_IS_FLOAT(CUI_TYPE_FIRST_LETTER(x))
#define CUI_IS_PRIMITIVE(x)         CUI_CHECK_IS_PRIMITIVE(CUI_TYPE_FIRST_LETTER(x))

#define CUI_IS_STRUCT(x)            (CUI_TYPE_FIRST_LETTER(x) == '{')
#define CUI_IS_POINT(x)             CUI_CHECK_IS_STRUCT_OF(x, CGPoint)
#define CUI_IS_SIZE(x)              CUI_CHECK_IS_STRUCT_OF(x, CGSize)
#define CUI_IS_RECT(x)              CUI_CHECK_IS_STRUCT_OF(x, CGRect)
#define CUI_IS_INSETS(x)            CUI_CHECK_IS_STRUCT_OF(x, UIEdgeInsets)
#define CUI_IS_FLOAT_LIST(x)        CUI_CHECK_IS_STRUCT_OF(x, CUIFloatList)
#define CUI_IS_BLOCK(x)             (x && [NSStringFromClass([x class]) rangeOfString:@"__NS.+Block__" options:NSRegularExpressionSearch].location != NSNotFound)



#define CUI_SYSTEM_VERSION_HIGHER_EQUAL(n)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= n)


#define CUI_FIRAT_VA_ARGS(start, type) \
Exp(\
va_list argList;\
va_start(argList, start);\
type value = va_arg(argList, type);\
va_end(argList);\
value\
)

//#define CUI_GET_VARIABLE_FLOAT_ARGUMENTS(start) \
//NSMutableArray *arguments = [NSMutableArray arrayWithObject:@(start)];\
//va_list argList;\
//va_start(argList, start);\
//CGFloat argument;\
//while ((argument = va_arg(argList, CGFloat)) != CUINull) {\
//    [arguments addObject:@(argument)];\
//}\
//va_end(argList);

#define CUI_GET_VARIABLE_OBJECT_ARGUMENTS(start) \
NSMutableArray *arguments = [NSMutableArray array];\
va_list argList;\
va_start(argList, start);\
id argument = 0;\
while ((argument = va_arg(argList, id))) {\
    [arguments addObject:argument];\
}\
va_end(argList);




//http://stackoverflow.com/questions/2124339/c-preprocessor-va-args-number-of-arguments

#define CUI_NUMBER_OF_VA_ARGS(...)  CUI_NUMBER_OF_VA_ARGS_(__VA_ARGS__, CUI_RSEQ_N())
#define CUI_NUMBER_OF_VA_ARGS_(...) CUI_ARG_N(__VA_ARGS__)

#define CUI_ARG_N( \
_1, _2, _3, _4, _5, _6, _7, _8, _9,_10, \
_11,_12,_13,_14,_15,_16,_17,_18,_19,_20, \
_21,_22,_23,_24,_25,_26,_27,_28,_29,_30, \
_31,_32,_33,_34,_35,_36,_37,_38,_39,_40, \
_41,_42,_43,_44,_45,_46,_47,_48,_49,_50, \
_51,_52,_53,_54,_55,_56,_57,_58,_59,_60, \
_61,_62,_63,N,...) N

#define CUI_RSEQ_N() \
63,62,61,60,                   \
59,58,57,56,55,54,53,52,51,50, \
49,48,47,46,45,44,43,42,41,40, \
39,38,37,36,35,34,33,32,31,30, \
29,28,27,26,25,24,23,22,21,20, \
19,18,17,16,15,14,13,12,11,10, \
9,8,7,6,5,4,3,2,1,0


#define WeakifySelf()       __weak typeof(self) weakSelf = self; weakSelf;
#define StrongifySelf()     typeof(weakSelf) self = weakSelf; self;


#define CUI_SYNTHESIZE(getter, setter, ...) \
- (id)getter {\
return objc_getAssociatedObject(self, _cmd);\
}\
- (void)setter:(id)getter {\
objc_setAssociatedObject(self, @selector(getter), getter, OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define CUI_SYNTHESIZE_BLOCK(getter, setter, type, ...) \
- (type)getter {\
return objc_getAssociatedObject(self, _cmd);\
}\
- (void)setter:(type)getter {\
objc_setAssociatedObject(self, @selector(getter), getter, OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define CUI_SYNTHESIZE_BOOL(getter, setter, ...) \
- (BOOL)getter {\
return [objc_getAssociatedObject(self, _cmd) boolValue];\
}\
- (void)setter:(BOOL)getter {\
objc_setAssociatedObject(self, @selector(getter), @(getter), OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define CUI_SYNTHESIZE_INT(getter, setter, ...) \
- (NSInteger)getter {\
return [objc_getAssociatedObject(self, _cmd) integerValue];\
}\
- (void)setter:(NSInteger)getter {\
objc_setAssociatedObject(self, @selector(getter), @(getter), OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define CUI_SYNTHESIZE_FLOAT(getter, setter, ...) \
- (CGFloat)getter {\
return [objc_getAssociatedObject(self, _cmd) floatValue];\
}\
- (void)setter:(CGFloat)getter {\
objc_setAssociatedObject(self, @selector(getter), @(getter), OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define CUI_SYNTHESIZE_RANGE(getter, setter, ...) \
- (NSRange)getter {\
return [objc_getAssociatedObject(self, _cmd) rangeValue];\
}\
- (void)setter:(NSRange)getter {\
objc_setAssociatedObject(self, @selector(getter), [NSValue valueWithRange:getter], OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define CUI_SYNTHESIZE_STRUCT(getter, setter, type, ...) \
- (type)getter {\
return [objc_getAssociatedObject(self, _cmd) type##Value];\
}\
- (void)setter:(type)getter {\
objc_setAssociatedObject(self, @selector(getter), [NSValue valueWith##type:getter], OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}



