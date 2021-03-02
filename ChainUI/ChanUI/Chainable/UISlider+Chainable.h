//
//  UISlider+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"

#define Slider  [UISlider new]

NS_ASSUME_NONNULL_BEGIN

@interface UISlider (Chainable)


/**
 * value, this value will be pinned to min/max.
 * It's better to set minVal/maxVal before setting val.
 * Usages: .val(50)
 */
CUI_SLIDER_PROP(Float)      val;

/**
 * minimumValue
 * Usages: .minVal(0)
 */
CUI_SLIDER_PROP(Float)      minVal;
/**
 * maximumValue
 * Usages: .maxVal(100)
 */
CUI_SLIDER_PROP(Float)      maxVal;

/**
 * Setting minimumTrack with color or image.
 * Usages:
    .minTrack(@"red"), .minTrack(@"255,0,0"), etc.
    .minTrack(Img(@"minImage")), .minTrack(@"minImage"), etc.
 */
CUI_SLIDER_PROP(Object)     minTrack;

/**
 * Setting maximumTrack with color or image.
 * Usages:
    .maxTrack(@"red"), .maxTrack(@"255,0,0"), etc.
    .maxTrack(Img(@"maxImage")), .maxTrack(@"maxImage"), etc.
 */
CUI_SLIDER_PROP(Object)     maxTrack;

/**
 * Setting thumb with color or image.
 * Usages:
    .thumb(@"red"), .thumb(@"255,0,0"), etc.
    .thumb(Img(@"thumbImage")), .thumb(@"thumbImage"), etc.
 */
CUI_SLIDER_PROP(Object)     thumb;

/**
 * Setting highlighted thumb with color or image.
 * Usages:
    .highThumb(@"red"), .highThumb(@"255,0,0"), etc.
    .highThumb(Img(@"thumbImage")), .highThumb(@"thumbImage"), etc.
 */
CUI_SLIDER_PROP(Object)     highThumb;

/**
 * Setting track height.
 * Usages: .trackHeight(3)
 */
CUI_SLIDER_PROP(Float)      trackHeight;

/**
 * Customize the thumb image’s drawing rectangle.
 * Usages:
    .thumbInsets(10)                     top/left/bottom/right = 10
    .thumbInsets(10, 20)                 top/bottom = 10, left/right = 20
    .thumbInsets(10, 20, 30),            top = 10, left/right = 20, bottom = 30
    .thumbInsets(10, 20, 30, 40)         top = 10, left = 20, bottom = 30, right = 40
 */
CUI_SLIDER_PROP(Insets)     thumbInsets;

/**
 * Value did change callback.
 * Use UIControlEventValueChanged event internally.
 * It support two kind of arguments:
    1) a callback block
    2) a selector string
 
 * Usages:
    .onChange(^{}), .onChange(^(CGFloat value){}), .onChange(^(CGFloat value, UISlider *slider){})
    .onChange(@"sliderValueDidChange"), .onChange(@"sliderValueDidChange:")
 */
CUI_SLIDER_PROP(Callback)   onChange;

//continuous = NO
- (instancetype)discrete;

#define thumbInsets(...)    thumbInsets(CUI_NORMALIZE_INSETS(__VA_ARGS__))
@end

NS_ASSUME_NONNULL_END
