//
//  UIColor+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIColor+Chainable.h"
#import "CUIPrivates.h"


@implementation UIColor (Chainable)

- (CUIChainableUIColorFloatBlock)opacity {
    CUI_FLOAT_BLOCK(return [self colorWithAlphaComponent:value]);
}

- (CUIChainableUIColorFloatBlock)hueOffset {
    CUI_FLOAT_BLOCK(return [self cui_colorWithHueOffset:value saturationOffset:0 brightnessOffset:0]);
}

- (CUIChainableUIColorFloatBlock)saturate {
    CUI_FLOAT_BLOCK(return [self cui_colorWithHueOffset:0 saturationOffset:value brightnessOffset:0];);
}

- (CUIChainableUIColorFloatBlock)desaturate {
    CUI_FLOAT_BLOCK(return [self cui_colorWithHueOffset:0 saturationOffset:-value brightnessOffset:0]);
}

- (CUIChainableUIColorFloatBlock)brighten {
    CUI_FLOAT_BLOCK(return [self cui_colorWithHueOffset:0 saturationOffset:0 brightnessOffset:value]);
}

- (CUIChainableUIColorFloatBlock)darken {
    CUI_FLOAT_BLOCK(return [self cui_colorWithHueOffset:0 saturationOffset:0 brightnessOffset:-value]);
}

- (instancetype)complimentary {
    return self.hueOffset(0.5);
}
@end
