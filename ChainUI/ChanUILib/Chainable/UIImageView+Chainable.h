//
//  UIImageView+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"
#import "CUIPrivates.h"

#define ImageView   [UIImageView cui_littleHigherHuggingAndResistanceView]

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Chainable)

/**
 * Setting image or animationImages value. Will update imageView's size if haven't set yet.
 * img use Img() internally, so it can take any kind of arguments that Img() supported.
 * Additionally it can take an NSArray of image.
 
 * Usages:
    .img(@"imageName"), .img(@"#stretchableImageName"), .img(imageObject),
    .img(@[@"walk1", @"walk2", @"walk3"])
 
 * See UIImage+CUIChainable.h for more information.
 */
CUI_IV_PROP(Object)     img;

/**
 * Setting highlightedImage or highlightedAnimationImages.
 * highImg use Img() internally, so it can take any kind of arguments that Img() supported.
 
 * Usages:
    .highImg(@"imageName"), .highImg(@"#stretchableImageName"), .highImg(imageObject),
    .highImg(@[@"walk1", @"walk2", @"walk3"])
 
 * See UIImage+CUIChainable.h for more information.
 */
CUI_IV_PROP(Object)     highImg;


/**
 * ContentMode
 * Usages: .aspectFit
 */

//UIViewContentModeScaleAspectFit
- (instancetype)aspectFit;

//UIViewContentModeScaleAspectFill
- (instancetype)aspectFill;

//UIViewContentModeCenter
- (instancetype)centerMode;

@end

NS_ASSUME_NONNULL_END
