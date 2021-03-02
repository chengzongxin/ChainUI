//
//  UIVisualEffectView+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIVisualEffectView+Chainable.h"
#import "CUIPrivates.h"

@implementation UIVisualEffectView (Chainable)

- (instancetype)darkBlur {
    self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    return self;
}

- (instancetype)lightBlur {
    self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    return self;
}

- (instancetype)extraLightBlur {
    self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    return self;
}

- (CUIChainableUIVisualEffectViewObjectBlock)addVibrancyChild {
    CUI_OBJECT_BLOCK([self cui_addVibrancyChild:value]);
}
@end
