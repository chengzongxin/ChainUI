//
//  UIImage+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"
#import "CUIUtils.h"


/**
 * Create a UIImage.
 * Img argument can be:
   1) UIImage object
   2) @"imageName"
   3) @"#imageName": stretchable image
   4) Any color value that Color() supported.
 
 * Prefixing image name with # character will create an stretchable image.
 * Passing a color value will create an 1x1 size image with specific color.
 
 * Usages:  Img([UIImage imageNamed:@"cat"],
            Img(@"cat"),
            Img(@"#button-background"),
            Img(@"33,33,33,0.5"),
            Img(@"red").resize(100, 100)
 */
#define Img(x)      [CUIUtils imageWithImageObject:x]


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Chainable)

/**
 * Create subImage in rect.
 * Usages: .subImg(10, 10, 50, 50), .subImg(rect)
 */
CUI_IMG_PROP(Rect)      subImg;

/**
 * Resize image.
 * Usages: .resize(100, 100)
 */
CUI_IMG_PROP(TwoFloat)  resize;

/**
 * resizableImage with UIImageResizingModeTile.
 * Usages:
    .tileInsets(10)                     top/left/bottom/right = 10
    .tileInsets(10, 20)                 top/bottom = 10, left/right = 20
    .tileInsets(10, 20, 30),            top = 10, left/right = 20, bottom = 30
    .tileInsets(10, 20, 30, 40)         top = 10, left = 20, bottom = 30, right = 40
 */
CUI_IMG_PROP(Insets)    tileInsets;

/**
 * resizableImage with UIImageResizingModeStretch.
 * Usages:
    .stretchInsets(10)                  top/left/bottom/right = 10
    .stretchInsets(10, 20)              top/bottom = 10, left/right = 20
    .stretchInsets(10, 20, 30),         top = 10, left/right = 20, bottom = 30
    .stretchInsets(10, 20, 30, 40)      top = 10, left = 20, bottom = 30, right = 40
 */
CUI_IMG_PROP(Insets)    stretchInsets;

/**
 * blur with radius.
 * Usages: .blur(8)
 */
CUI_IMG_PROP(Float)     blur;

//return a stretchable image (by stretching the center point)
- (instancetype)stretchable;

//return a template image (UIImageRenderingModeAlwaysTemplate)
- (instancetype)templates;

//return a origina image (UIImageRenderingModeAlwaysOriginal)
- (instancetype)original;

@end


#define subImg(...)             subImg((CUIRect){__VA_ARGS__})
#define tileInsets(...)         tileInsets(CUI_NORMALIZE_INSETS(__VA_ARGS__))
#define stretchInsets(...)      stretchInsets(CUI_NORMALIZE_INSETS(__VA_ARGS__))



NS_ASSUME_NONNULL_END
