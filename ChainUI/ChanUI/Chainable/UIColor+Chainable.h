//
//  UIColor+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"
#import "CUIUtils.h"
NS_ASSUME_NONNULL_BEGIN

/**
 * Create a UIColor.
 * Color argument can be:
   1) UIColor object
   2) UIImage object, return a pattern image color
   3) @"red", @"green", @"blue", @"clear", etc. (any system color)
   5) @"random": randomColor
   6) @"255,0,0": RGB color
   7) @"#FF0000" or @"0xF00": Hex color
 
 * All the string representation can have an optional alpha value.
 
 * Usages: Color([UIColor redColor]),
           Color(@"red"),
           Color(@"red,0.5"),
           Color(@"255,0,0,1"),
           Color(@"#F00,0.5"),
           Color(@"random,0.5")
 */
#define Color(x)    [CUIUtils colorWithColorObject:x]

@interface UIColor (Chainable)

/**
 * Setting alpha value.
 * Usages: .opacity(0.5)
 */
CUI_COLOR_PROP(Float)   opacity;

/**
 * Adjust hue value.
 * Argument range: [0~1]
 * Usages: .hueOffset(1.0f / 3), hueOffset(-0.2)
 */
CUI_COLOR_PROP(Float)   hueOffset;

/**
 * Increase saturation value.
 * Argument range: [0~1]
 * Usages: .saturate(0.1)
 */
CUI_COLOR_PROP(Float)   saturate;

/**
 * Decrease saturation value.
 * Argument range: [0~1]
 * Usages: .desaturate(0.1)
 */
CUI_COLOR_PROP(Float)   desaturate;

/**
 * Increase brightness value.
 * Argument range: [0~1]
 * Usages: .brighten(0.2)
 */
CUI_COLOR_PROP(Float)   brighten;

/**
 * Decrease brightness value.
 * Argument range: [0~1]
 * Usages: .darken(0.2)
 */
CUI_COLOR_PROP(Float)   darken;

/**
 * The opposite color on the color wheel.
 */
- (instancetype)complimentary;

@end



NS_ASSUME_NONNULL_END
