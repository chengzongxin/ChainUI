//
//  UIPageControl+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIPageControl+Chainable.h"
#import "UIColor+Chainable.h"
#import "CUIPrivates.h"
#import "CUIUtils.h"


@implementation UIPageControl (Chainable)

- (CUIChainableUIPageControlIntBlock)pages {
    CUI_INT_BLOCK(
                  self.numberOfPages = value;
                  if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
                      [self sizeToFit];
                  }
                  );
}

- (CUIChainableUIPageControlObjectBlock)color {
    CUI_OBJECT_BLOCK(self.pageIndicatorTintColor = Color(value));
}

- (CUIChainableUIPageControlObjectBlock)highColor {
    CUI_OBJECT_BLOCK(self.currentPageIndicatorTintColor = Color(value));
}

- (CUIChainableUIPageControlCallbackBlock)onChange {
    CUI_CALLBACK_BLOCK(return [self cui_registerOnChangeHandlerWithTarget:target object:object];);
}

- (instancetype)hideForSingle {
    self.hidesForSinglePage = YES;
    return self;
}

@end
