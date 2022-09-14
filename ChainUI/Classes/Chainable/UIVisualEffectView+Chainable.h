//
//  UIVisualEffectView+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"

/**
 * Usages:
    1) EffectView.lightBlur.embedIn(self.view);
 
    2) id textLabel = Label.str(@"HELLO WORLD").fnt(@40);
       id candy = ImageView.img(Img(@"candy").template);
       id stack = VStack(textLabel, candy).centerAlignment.fitSize.cxy(self.view.center);
       EffectView.extraLightBlur.addVibrancyChild(stack).embedIn(self.view);
 */

#define EffectView  [UIVisualEffectView new]


NS_ASSUME_NONNULL_BEGIN

@interface UIVisualEffectView (Chainable)

/**
 * Add vibrancy Subviews. It can take one or more arguments.
 * For UIImageView subview, its image have to render as UIImageRenderingModeAlwaysTemplate.
 * Usages: .addVibrancyChild(subview), .addVibrancyChild(subview1, subview2, subview3, ...)
 */
CUI_EFFECT_PROP(Object) addVibrancyChild;

//UIBlurEffectStyleDark
- (instancetype)darkBlur;

//UIBlurEffectStyleLight
- (instancetype)lightBlur;

//UIBlurEffectStyleExtraLight
- (instancetype)extraLightBlur;

#define addVibrancyChild(...)   addVibrancyChild(@[__VA_ARGS__])

@end

NS_ASSUME_NONNULL_END
