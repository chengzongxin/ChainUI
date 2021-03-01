//
//  UILabel+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"

#define Label   [UILabel new]

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Chainable)

/**
 * Setting text or attributedText value.
 * str use Str() internally, so it can take any kind of arguments that Str() supported.
 * Additionally it can take an NSAttributedString object.
 
 * Usages:
    .str(100), .str(@3.14), .str(@"hello"), .str(@"%d+%d=%d", 1, 1, 1 + 1),
    .str(someAttributedString), .str(AttStr(@"hello").fnt(20).underline), etc.
 
 * See NSString+CUIChainable.h and NSAttributedString+CUIChainable.h for more information.
 */
CUI_LABEL_PROP(Object)      str;

/**
 * font
 * fnt use Fnt() internally, so it can take any kind of arguments that Fnt() supported.
 * Usages: .fnt(15), .fnt(@15), .fnt(@"headline"), .fnt(@"Helvetica,15"), .fnt(fontObject), etc.
 * See UIFont+CUIChainable.h for more information.
 */
CUI_LABEL_PROP(Object)      fnt;

/**
 * textColor
 * color use Color() internally, so it can take any kind of arguments that Color() supported.
 * Usages: .color(@"red"), .color(@"#F00"), .color(@"255,0,0"), .color(colorObject), etc.
 * See UIColor+CUIChainable.h for more information.
 */
CUI_LABEL_PROP(Object)      txtColor;

/**
 * highlightedTextColor
 * highColor use Color() internally, so it can take any kind of arguments that Color() supported.
 * Usages: .highColor(@"red"), .highColor(@"#F00"), .highColor(@"255,0,0"), .highColor(colorObject), etc.
 * See UIColor+CUIChainable.h for more information.
 */
CUI_LABEL_PROP(Object)      highColor;

/**
 * numberOfLines
 * Usages: .lines(0)
 */
CUI_LABEL_PROP(Int)         lines;

/**
 * lineSpacing
 * Usages: .lineGap(5)
 */
CUI_LABEL_PROP(Float)       lineGap;

/**
 * preferredMaxLayoutWidth
 * Usages: .preferWidth(300)
 */
CUI_LABEL_PROP(Float)       preferWidth;

/**
 * Add Link selection handler.
 * It support two kind of arguments:
   1) a callback block
   2) a selector string
 
 * Usages:
    .onLink(^{});
    .onLink(^(id text) {});
    .onLink(^(id text, NSRange range) {});
    .onLink(@"onLink"), .onLink(@"onLink:"), .onLink(@"onLink:range:")
 
 * Link example:
    id att = AttStr(@"hello world").match(@"hello").linkForLabel;
    Label.str(att).embedIn(self.view).onLink(^(id text) {
        Log(text);
    });
 
 * See NSAttributedString+CUIChainable.h for more information on how to create Link AttributedString for UILabel.
 */
CUI_LABEL_PROP(Callback)    onLink;


/**
 * Enable multiline, same as .lines(0)
 * Usages: .multiline
 */
- (instancetype)multiline;

/**
 * TextAlignment
 * Usages: .centerAlignment
 */
- (instancetype)leftAlignment;
- (instancetype)centerAlignment;
- (instancetype)rightAlignment;
- (instancetype)justifiedAlignment;

@end

NS_ASSUME_NONNULL_END
