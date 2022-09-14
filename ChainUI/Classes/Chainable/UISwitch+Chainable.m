//
//  UISwitch+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UISwitch+Chainable.h"
#import "UIColor+Chainable.h"
#import "CUIUtils.h"
#import "CUIPrivates.h"

@implementation UISwitch (Chainable)
- (CUIChainableUISwitchObjectBlock)onColor {
    CUI_OBJECT_BLOCK(self.onTintColor = Color(value));
}

- (CUIChainableUISwitchObjectBlock)thumbColor {
    CUI_OBJECT_BLOCK(self.thumbTintColor = Color(value));
}

- (CUIChainableUISwitchObjectBlock)outlineColor {
    CUI_OBJECT_BLOCK(self.tintColor = Color(value));
}

- (CUIChainableUISwitchCallbackBlock)onChange {
    CUI_CALLBACK_BLOCK(return [self cui_registerOnChangeHandlerWithTarget:target object:object]);
}
@end
