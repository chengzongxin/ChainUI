//
//  UIStepper+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIStepper+Chainable.h"
#import "UIColor+Chainable.h"
#import "CUIUtils.h"
#import "CUIPrivates.h"


@implementation UIStepper (Chainable)

- (CUIChainableUIStepperFloatBlock)val {
    CUI_FLOAT_BLOCK(self.value = value);
}

- (CUIChainableUIStepperFloatBlock)minVal {
    CUI_FLOAT_BLOCK(self.minimumValue = value);
}

- (CUIChainableUIStepperFloatBlock)maxVal {
    CUI_FLOAT_BLOCK(self.maximumValue = value);
}

- (CUIChainableUIStepperFloatBlock)stepVal {
    CUI_FLOAT_BLOCK(self.stepValue = value);
}

- (CUIChainableUIStepperCallbackBlock)onChange {
    CUI_CALLBACK_BLOCK(return [self cui_registerOnChangeHandlerWithTarget:target object:object];);
}
@end
