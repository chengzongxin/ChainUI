//
//  UISlider+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UISlider+Chainable.h"
#import "CUIUtils.h"
#import "CUIPrivates.h"


@implementation UISlider (Chainable)

- (CUIChainableUISliderFloatBlock)val {
    CUI_FLOAT_BLOCK(self.value = value);
}

- (CUIChainableUISliderFloatBlock)minVal {
    CUI_FLOAT_BLOCK(self.minimumValue = value);
}

- (CUIChainableUISliderFloatBlock)maxVal {
    CUI_FLOAT_BLOCK(self.maximumValue = value);
}

- (CUIChainableUISliderObjectBlock)minTrack {
    CUI_OBJECT_BLOCK(
                     id result = [CUIUtils imageOrColorWithObject:value];
                     if ([result isKindOfClass:UIColor.class]) {
                         self.minimumTrackTintColor = result;
                     } else {
                         [self setMinimumTrackImage:result forState:UIControlStateNormal];
                     }
    );
}

- (CUIChainableUISliderObjectBlock)maxTrack {
    CUI_OBJECT_BLOCK(
                     id result = [CUIUtils imageOrColorWithObject:value];
                     if ([result isKindOfClass:UIColor.class]) {
                         self.maximumTrackTintColor = result;
                     } else {
                         [self setMaximumTrackImage:result forState:UIControlStateNormal];
                     }
    );
}

- (CUIChainableUISliderObjectBlock)thumb {
    CUI_OBJECT_BLOCK(
                     id result = [CUIUtils imageOrColorWithObject:value];
                     if ([result isKindOfClass:UIColor.class]) {
                         self.thumbTintColor = result;
                     } else {
                         [self setThumbImage:result forState:UIControlStateNormal];
                     }
                     );
}

- (CUIChainableUISliderObjectBlock)highThumb {
    CUI_OBJECT_BLOCK(
                     id result = [CUIUtils imageOrColorWithObject:value];
                     if ([result isKindOfClass:UIImage.class]) {
                         [self setThumbImage:result forState:UIControlStateHighlighted];
                     }
                     );
}

- (CUIChainableUISliderFloatBlock)trackHeight {
    CUI_FLOAT_BLOCK(self.cuiTrackHeight = @(value));
}

- (CUIChainableUISliderInsetsBlock)thumbInsets {
    CUI_INSETS_BLOCK(self.cuiThumbInsets = value);
}

- (CUIChainableUISliderCallbackBlock)onChange {
    CUI_CALLBACK_BLOCK([self cui_registerOnChangeHandlerWithTarget:target object:object]);
}

- (instancetype)discrete {
    self.continuous = NO;
    return self;
}
@end
