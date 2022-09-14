//
//  UITextField+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UITextField+Chainable.h"
#import "UIColor+Chainable.h"
#import "UIFont+Chainable.h"
#import "CUIPrivates.h"
#import "CUIUtils.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation UITextField (Chainable)

- (CUIChainableUITextFieldObjectBlock)str {
    CUI_OBJECT_BLOCK([CUIUtils setTextWithStringObject:value forView:self]);
}

- (CUIChainableUITextFieldObjectBlock)hint {
    CUI_OBJECT_BLOCK([CUIUtils setPlaceholderWithStringObject:value forView:self]);
}

- (CUIChainableUITextFieldObjectBlock)fnt {
    CUI_OBJECT_BLOCK(self.font = Fnt(value));
}

- (CUIChainableUITextFieldObjectBlock)color {
    CUI_OBJECT_BLOCK(self.textColor = Color(value));
}

- (CUIChainableUITextFieldIntBlock)maxLength {
    CUI_INT_BLOCK(self.cuiMaxLength = value);
}

- (CUIChainableUITextFieldInsetsBlock)insets {
    CUI_INSETS_BLOCK(self.cuiContentEdgeInsets = value);
}

- (CUIChainableUITextFieldCallbackBlock)onChange {
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

- (CUIChainableUITextFieldCallbackBlock)onFinish {
    CUI_CALLBACK_BLOCK(
                       if (CUI_IS_BLOCK(object)) {
                           self.cuiEndOnExitBlock = object;
                       } else {
                           self.cuiEndOnExitBlock = ^(id text) {
                               SEL action = NSSelectorFromString(object);
                               [weakTarget performSelector:action withObject:weakSelf];
                           };
                       }
    );
}

- (instancetype)secure {
    self.secureTextEntry = YES;
    return self;
}

- (instancetype)becomeFocus {
    [self becomeFirstResponder];
    return self;
}

- (instancetype)clearWhenFocus {
    self.clearsOnBeginEditing = YES;
    return self;
}

- (instancetype)roundStyle {
    self.borderStyle = UITextBorderStyleRoundedRect;
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

- (instancetype)ASCIIKeyboard {
    self.keyboardType = UIKeyboardTypeASCIICapable;
    return self;
}

- (instancetype)URLKeyboard {
    self.keyboardType = UIKeyboardTypeURL;
    return self;
}

- (instancetype)numberKeyboard {
    self.keyboardType = UIKeyboardTypeNumberPad;
    return self;
}

- (instancetype)phoneKeyboard {
    self.keyboardType = UIKeyboardTypePhonePad;
    return self;
}

- (instancetype)emailKeyboard {
    self.keyboardType = UIKeyboardTypeEmailAddress;
    return self;
}

- (instancetype)decimalKeyboard {
    self.keyboardType = UIKeyboardTypeDecimalPad;
    return self;
}

-(instancetype)twitterKeyboard {
    self.keyboardType = UIKeyboardTypeTwitter;
    return self;
}

- (instancetype)searchKeybaord {
    self.keyboardType = UIKeyboardTypeWebSearch;
    return self;
}

- (instancetype)namePhoneKeyboard {
    self.keyboardType = UIKeyboardTypeNamePhonePad;
    return self;
}

- (instancetype)numberPunctuationKeyboard {
    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    return self;
}

- (instancetype)goReturnKey {
    self.returnKeyType = UIReturnKeyGo;
    return self;
}

- (instancetype)googleReturnKey {
    self.returnKeyType = UIReturnKeyGoogle;
    return self;
}

- (instancetype)searchReturnKey {
    self.returnKeyType = UIReturnKeySearch;
    return self;
}

- (instancetype)sendReturnKey {
    self.returnKeyType = UIReturnKeySend;
    return self;
}

- (instancetype)doneReturnKey {
    self.returnKeyType = UIReturnKeyDone;
    return self;
}

- (instancetype)nextRetrunKey {
    self.returnKeyType = UIReturnKeyNext;
    return self;
}

- (instancetype)joinReturnKey {
    self.returnKeyType = UIReturnKeyJoin;
    return self;
}

- (instancetype)routeReturnKey {
    self.returnKeyType = UIReturnKeyRoute;
    return self;
}

- (instancetype)showClearButton {
    self.clearButtonMode = UITextFieldViewModeAlways;
    return self;
}

- (instancetype)showClearButtonWhileEditing {
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    return self;
}

- (instancetype)showClearButtonUnlessEditing {
    self.clearButtonMode = UITextFieldViewModeUnlessEditing;
    return self;
}

@end
