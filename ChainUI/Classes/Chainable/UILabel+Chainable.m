//
//  UILabel+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UILabel+Chainable.h"
#import "UILabel+CUILink.h"
#import "UIFont+Chainable.h"
#import "UIColor+Chainable.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation UILabel (Chainable)

- (CUIChainableUILabelObjectBlock)str {
    CUI_OBJECT_BLOCK([CUIUtils setTextWithStringObject:value forView:self]);
}

- (CUIChainableUILabelObjectBlock)fnt {
    CUI_OBJECT_BLOCK(self.font = Fnt(value));
}

- (CUIChainableUILabelObjectBlock)txtColor {
    CUI_OBJECT_BLOCK(self.textColor = Color(value));
}

- (CUIChainableUILabelObjectBlock)highColor {
    CUI_OBJECT_BLOCK(self.highlightedTextColor = Color(value));
}

- (CUIChainableUILabelIntBlock)lines {
    CUI_INT_BLOCK(self.numberOfLines = value);
}

- (CUIChainableUILabelFloatBlock)lineGap {
    CUI_FLOAT_BLOCK(self.cuiLineGap = value);
}

- (CUIChainableUILabelFloatBlock)preferWidth {
    CUI_FLOAT_BLOCK(self.preferredMaxLayoutWidth = value);
}

- (CUIChainableUILabelCallbackBlock)onLink {
    CUI_CALLBACK_BLOCK(
                       
                       if (CUI_IS_BLOCK(object)) {
                           self.cuiLinkHandler = object;
                           
                       } else {
                           self.cuiLinkHandler = ^(id text, NSRange range) {
                               id rangeValue = [NSValue valueWithRange:range];
                               SEL action = NSSelectorFromString(object);
                               [weakTarget performSelector:action withObject:text withObject:rangeValue];
                           };
                       }
                       self.userInteractionEnabled = YES;
                       );
}

- (instancetype)multiline {
    self.numberOfLines = 0;
    return self;
}

- (instancetype)leftAlignment {
    self.textAlignment = NSTextAlignmentLeft;
    return self;
}

- (instancetype)centerAlignment {
    self.textAlignment = NSTextAlignmentCenter;
    return self;
}

- (instancetype)rightAlignment {
    self.textAlignment = NSTextAlignmentRight;
    return self;
}

- (instancetype)justifiedAlignment {
    self.textAlignment = NSTextAlignmentJustified;
    return self;
}

@end
