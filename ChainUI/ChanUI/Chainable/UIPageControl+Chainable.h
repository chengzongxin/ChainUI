//
//  UIPageControl+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"

#define PageControl     [UIPageControl new]

NS_ASSUME_NONNULL_BEGIN

@interface UIPageControl (Chainable)

/**
 * numberOfPages
 * Usages: .pages(5)
 */
CUI_PC_PROP(Int)        pages;

/**
 * pageIndicatorTintColor
 * The tint color to be used for the page indicator.
 * color use Color() internally, so it can take any kind of arguments that Color() supported.
 * Usages: .color(@"red"), .color(@"#F00"), .color(@"255,0,0"), .color(colorObject), etc.
 * See UIColor+CUIChainable.h for more information.
 */
CUI_PC_PROP(Object)     color;

/**
 * currentPageIndicatorTintColor
 * The tint color to be used for the current page indicator.
 * highColor use Color() internally, so it can take any kind of arguments that Color() supported.
 * Usages: .highColor(@"red"), .highColor(@"#F00"), .highColor(@"255,0,0"), .highColor(colorObject), etc.
 * See UIColor+CUIChainable.h for more information.
 */
CUI_PC_PROP(Object)     highColor;

/**
 * Value did change callback.
 * Use UIControlEventValueChanged event internally.
 * It support two kind of arguments:
    1) a callback block
    2) a selector string
 
 * Usages:
    .onChange(^{}), .onChange(^(NSInteger currentPage){}), .onChange(^(NSInteger currentPage, id pageControl){})
    .onChange(@"switchValueDidChange"), .onChange(@"switchValueDidChange:")
 */
CUI_PC_PROP(Callback)   onChange;


//hidesForSinglePage
- (instancetype)hideForSingle;

@end

NS_ASSUME_NONNULL_END
