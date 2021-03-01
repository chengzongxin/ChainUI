//
//  UISegmentedControl+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"
#import "CUIPrivates.h"

/**
 * Create UISegmentedControl with items.
 * Items can be NSStrings or UIImages.
 * Usages: Segmented(@"Item1", @"Item2", Img(@"cat"))
 */
#define Segmented(...)  [UISegmentedControl cui_segmentedControlWithItems:@[__VA_ARGS__]]

NS_ASSUME_NONNULL_BEGIN

@interface UISegmentedControl (Chainable)


/**
 * Value did change callback.
 * Use UIControlEventValueChanged event internally.
 * It support two kind of arguments:
    1) a callback block
    2) a selector string
 
 * Usages:
    .onChange(^{}), .onChange(^(NSInteger selectedIndex){}), .onChange(^(NSInteger selectedIndex, id segmentedControl){})
    .onChange(@"segmentedControlValueDidChange"), .onChange(@"segmentedControlValueDidChange:")
 */
CUI_SEGMENTED_PROP(Callback)    onChange;
@end

NS_ASSUME_NONNULL_END
