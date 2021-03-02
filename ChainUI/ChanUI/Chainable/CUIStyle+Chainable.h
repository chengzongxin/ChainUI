//
//  CUIStyle+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIStyle.h"
#import "CUIDefs.h"


/**
 * Nearly all the chainable attributes In NerdyUI can be set in Style.
 * After creation, Styles can be apply to UIView or NSAttributedStirng.
 * Style can inherit from other styles too.
 * Style with name can be referred globally.
 
 * Example:
    Style(@"h1").color(@"#333333").fnt(17);
    Style(@"button").fixHeight(30).insets(0, 10).borderRadius(5);
    id actionStyle = Style().styles(@"button h1").bgImg(@"red").highBgImg(@"blue").highColor(@"white");
 
    id foo = Label.styles(@"h1").str(@"hello world");
    id bar = Button.styles(actionStyle).str(@"hello world");
 */
#define Style(...)                [CUIStyle createStyleWithKeys:@[__VA_ARGS__]]


NS_ASSUME_NONNULL_BEGIN

@interface CUIStyle (Chainable)

/**
 * Style can inherit from other styles too.
 * For multiply styles, use white space to separate them.
 * Usages: .styles(@"style1"), .styles(@"style1 style2 style3 style4"), .styles(localStyle)
 */
CUI_STYLE_PROP(Object)          styles;


/**
 * UIView
 */
CUI_STYLE_PROP(Int)             tg;
CUI_STYLE_PROP(Float)           opacity;
CUI_STYLE_PROP(Object)          tint;
CUI_STYLE_PROP(Object)          bgColor;
CUI_STYLE_PROP(Float)           borderRadius;
CUI_STYLE_PROP(FloatObjectList) border;
CUI_STYLE_PROP(FloatList)       shadow;
CUI_STYLE_PROP(Rect)            xywh;
CUI_STYLE_PROP(Point)           cxy;
CUI_STYLE_PROP(Float)           horHugging;
CUI_STYLE_PROP(Float)           verHugging;
CUI_STYLE_PROP(Float)           horResistance;
CUI_STYLE_PROP(Float)           verResistance;
CUI_STYLE_PROP(Float)           fixWidth;
CUI_STYLE_PROP(Float)           fixHeight;
CUI_STYLE_PROP(Size)            fixWH;

- (instancetype)clip;
- (instancetype)touchEnable;
- (instancetype)touchDisable;
- (instancetype)stateDisabled;
- (instancetype)invisible;
- (instancetype)fitWidth;
- (instancetype)fitHeight;
- (instancetype)fitSize;
- (instancetype)flexibleLeft;
- (instancetype)flexibleRight;
- (instancetype)flexibleTop;
- (instancetype)flexibleBottom;
- (instancetype)flexibleLR;
- (instancetype)flexibleTB;
- (instancetype)flexibleLRTB;
- (instancetype)flexibleWidth;
- (instancetype)flexibleHeight;
- (instancetype)flexibleWH;
- (instancetype)lowHugging;
- (instancetype)highHugging;
- (instancetype)lowResistance;
- (instancetype)highResistance;



/**
 * UILabel
 */
CUI_STYLE_PROP(Object)          str;
CUI_STYLE_PROP(Object)          fnt;
CUI_STYLE_PROP(Object)          color;
CUI_STYLE_PROP(Object)          highColor;
CUI_STYLE_PROP(Int)             lines;
CUI_STYLE_PROP(Float)           lineGap;
CUI_STYLE_PROP(Float)           preferWidth;

- (instancetype)multiline;
- (instancetype)leftAlignment;
- (instancetype)centerAlignment;
- (instancetype)rightAlignment;
- (instancetype)justifiedAlignment;



/**
 * UIImageView
 */
CUI_STYLE_PROP(Object)          img;
CUI_STYLE_PROP(Object)          highImg;

- (instancetype)aspectFit;
- (instancetype)aspectFill;
- (instancetype)centerMode;



/**
 * UIButton
 */
CUI_STYLE_PROP(Object)          selectedColor;
CUI_STYLE_PROP(Object)          disabledColor;
CUI_STYLE_PROP(Object)          selectedImg;
CUI_STYLE_PROP(Object)          disabledImg;
CUI_STYLE_PROP(Object)          bgImg;
CUI_STYLE_PROP(Object)          highBgImg;
CUI_STYLE_PROP(Object)          selectedBgImg;
CUI_STYLE_PROP(Object)          disabledBgImg;
CUI_STYLE_PROP(Float)           gap;
CUI_STYLE_PROP(Insets)          insets;

- (instancetype)reversed;
- (instancetype)adjustDisabled;



/**
 * UITextField
 */
CUI_STYLE_PROP(Object)          hint;
CUI_STYLE_PROP(Int)             maxLength;

- (instancetype)secure;
- (instancetype)becomeFocus;
- (instancetype)clearWhenFocus;
- (instancetype)roundStyle;
- (instancetype)ASCIIKeyboard;
- (instancetype)URLKeyboard;
- (instancetype)numberKeyboard;
- (instancetype)phoneKeyboard;
- (instancetype)emailKeyboard;
- (instancetype)decimalKeyboard;
- (instancetype)twitterKeyboard;
- (instancetype)searchKeybaord;
- (instancetype)namePhoneKeyboard;
- (instancetype)numberPunctuationKeyboard;
- (instancetype)doneReturnKey;
- (instancetype)goReturnKey;
- (instancetype)googleReturnKey;
- (instancetype)searchReturnKey;
- (instancetype)sendReturnKey;
- (instancetype)nextRetrunKey;
- (instancetype)joinReturnKey;
- (instancetype)routeReturnKey;
- (instancetype)showClearButton;
- (instancetype)showClearButtonWhileEditing;
- (instancetype)showClearButtonUnlessEditing;



/**
 * UISwitch
 */
CUI_STYLE_PROP(Object)          onColor;
CUI_STYLE_PROP(Object)          thumbColor;
CUI_STYLE_PROP(Object)          outlineColor;



/**
 * UISlider
 */
CUI_STYLE_PROP(Float)           val;
CUI_STYLE_PROP(Float)           minVal;
CUI_STYLE_PROP(Float)           maxVal;
CUI_STYLE_PROP(Object)          minTrack;
CUI_STYLE_PROP(Object)          maxTrack;
CUI_STYLE_PROP(Object)          thumb;
CUI_STYLE_PROP(Object)          highThumb;
CUI_STYLE_PROP(Float)           trackHeight;
CUI_STYLE_PROP(Insets)          thumbInsets;

- (instancetype)discrete;



/**
 * UIStepper
 */
CUI_STYLE_PROP(Float)           stepVal;



/**
 * UIPageControl
 */
CUI_STYLE_PROP(Int)             pages;

- (instancetype)hideForSingle;



/**
 * UIVisualEffectView
 */
- (instancetype)darkBlur;
- (instancetype)lightBlur;
- (instancetype)extraLightBlur;



/**
 * CUIStack
 */
- (instancetype)topAlignment;
- (instancetype)bottomAlignment;
- (instancetype)baselineAlignment;
- (instancetype)firstBaselineAlignment;



/**
 * CUIStaticRow
 */
CUI_STYLE_PROP(Object)          detailStr;
CUI_STYLE_PROP(Object)          detailFnt;
CUI_STYLE_PROP(Object)          detailColor;
CUI_STYLE_PROP(Object)          accessory;
CUI_STYLE_PROP(Bool)            check;
CUI_STYLE_PROP(Float)           cellHeight;
CUI_STYLE_PROP(Float)           separatorLeftInset;

- (instancetype)cellHeightAuto;
- (instancetype)subtitleStyle;
- (instancetype)value2Style;
- (instancetype)disclosure;



/**
 * CUIStaticSection
 */
CUI_STYLE_PROP(Object)          header;
CUI_STYLE_PROP(Object)          footer;

- (instancetype)singleCheck;
- (instancetype)multiCheck;



/**
 * NSMutableAttributedString
 */
CUI_STYLE_PROP(Object)          systemLink;
CUI_STYLE_PROP(Float)           kern;
CUI_STYLE_PROP(Float)           stroke;
CUI_STYLE_PROP(Float)           oblique;
CUI_STYLE_PROP(Float)           expansion;
CUI_STYLE_PROP(Float)           baselineOffset;
CUI_STYLE_PROP(Float)           indent;
CUI_STYLE_PROP(Object)          match;

- (instancetype)matchNumber;
- (instancetype)matchURL;
- (instancetype)matchHashTag;
- (instancetype)matchNameTag;
- (instancetype)underline;
- (instancetype)strikeThrough;
- (instancetype)letterpress;
- (instancetype)linkForLabel;
- (instancetype)ifNotExists;

@end

NS_ASSUME_NONNULL_END
