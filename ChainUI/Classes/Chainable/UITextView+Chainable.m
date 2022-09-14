//
//  UITextView+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UITextView+Chainable.h"
#import "UIColor+Chainable.h"
#import "UIFont+Chainable.h"
#import "CUIPrivates.h"
#import "CUIUtils.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


@implementation UITextView (Chainable)

- (CUIChainableUITextViewObjectBlock)str {
    CUI_OBJECT_BLOCK([CUIUtils setTextWithStringObject:value forView:self]);
}

- (CUIChainableUITextViewObjectBlock)hint {
    CUI_OBJECT_BLOCK([self cui_setPlaceholderText:value]);
}

- (CUIChainableUITextViewObjectBlock)fnt {
    CUI_OBJECT_BLOCK(self.font = Fnt(value));
}

- (CUIChainableUITextViewObjectBlock)color {
    CUI_OBJECT_BLOCK(self.textColor = Color(value));
}

- (CUIChainableUITextViewInsetsBlock)insets {
    CUI_INSETS_BLOCK(
                    self.textContainer.lineFragmentPadding = 0;
                    self.textContainerInset = value;
                     );
}

- (CUIChainableUITextViewIntBlock)maxLength {
    CUI_INT_BLOCK(self.cuiMaxLength = value);
}

- (CUIChainableUITextViewCallbackBlock)onChange {
    CUI_CALLBACK_BLOCK(
                       if (CUI_IS_BLOCK(object)) {
                           self.cuiTextChangeBlock = object;
                       } else {
                           self.cuiTextChangeBlock = ^(id text) {
                               SEL action = NSSelectorFromString(object);
                               [weakTarget performSelector:action withObject:weakSelf];
                           };
                       }
                       );
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

- (instancetype)becomeFocus {
    [self becomeFirstResponder];
    return self;
}

@end
