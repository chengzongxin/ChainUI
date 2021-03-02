//
//  UIStepper+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"

#define Stepper     [UIStepper new]


NS_ASSUME_NONNULL_BEGIN

@interface UIStepper (Chainable)

/**
 * value, this value will be pinned to min/max.
 * It's better to set minVal/maxVal before setting val.
 * Usages: .val(50)
 */
CUI_STEPPER_PROP(Float)     val;

/**
 * minimumValue
 * Usages: .minVal(0)
 */
CUI_STEPPER_PROP(Float)     minVal;

/**
 * maximumValue
 * Usages: .maxVal(100)
 */
CUI_STEPPER_PROP(Float)     maxVal;

/**
 * stepValue
 * Usages: .stepVal(2)
 */
CUI_STEPPER_PROP(Float)     stepVal;

/**
 * Value did change callback.
 * Use UIControlEventValueChanged event internally.
 * It support two kind of arguments:
 1) a callback block
 2) a selector string
 
 * Usages:
    .onChange(^{}), .onChange(^(NSInteger value){}), .onChange(^(NSInteger value, id stepper){})
    .onChange(@"stepperValueDidChange"), .onChange(@"stepperValueDidChange:")
 */
CUI_STEPPER_PROP(Callback)  onChange;

@end

NS_ASSUME_NONNULL_END
