//
//  UISegmentedControl+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UISegmentedControl+Chainable.h"
#import "UIColor+Chainable.h"
#import "CUIUtils.h"

@implementation UISegmentedControl (Chainable)

- (CUIChainableUISegmentedControlCallbackBlock)onChange {
    CUI_CALLBACK_BLOCK(return [self cui_registerOnChangeHandlerWithTarget:target object:object];;);
}

@end
