//
//  UIFont+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIUtils.h"

NS_ASSUME_NONNULL_BEGIN


/**
 * Create a UIFont.
 * Fnt argument can be:
   1) UIFont object
   2) 15: systemFontOfSize 15
   3) @15: boldSystemFontOfSize 15
   4) @"headline", @"body", @"caption1", and any other UIFontTextStyle.
   5) @"Helvetica,15": fontName + fontSize, separated by comma.
 
 * Usages: Fnt([UIFont systemFontOfSize:15]),
           Fnt(15),
           Fnt(@15),
           Fnt(@"body"),
           Fnt(@"Helvetica,15")
 */
#define Fnt(x)  [CUIUtils fontWithFontObject:CUI_CONVERT_VALUE_TO_STRING(x)]

#warning 打开会编译报错,不能在头文件声明

#define UIFont_Cat \
@interface UIFont (Chainable)\
@end




NS_ASSUME_NONNULL_END
