//
//  UIImageView+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIImageView+Chainable.h"
#import "UIImage+Chainable.h"
#import "NSArray+Chainable.h"

@implementation UIImageView (Chainable)

- (CUIChainableUIImageViewObjectBlock)img {
    CUI_OBJECT_BLOCK(
                     if ([value isKindOfClass:[NSArray class]]) {
                         self.animationImages = ((NSArray *)value).map(^(id imageObject) {
                             return Img(imageObject);
                         });
                         [CUIUtils updateViewSizeIfNeed:self withImage:self.animationImages.firstObject];
                     } else {
                         self.image = Img(value);
                         [CUIUtils updateViewSizeIfNeed:self withImage:self.image];
                     }
                     );
}

- (CUIChainableUIImageViewObjectBlock)highImg {
    CUI_OBJECT_BLOCK(
                     if ([value isKindOfClass:[NSArray class]]) {
                         self.highlightedAnimationImages = value;
                     } else {
                         self.highlightedImage = Img(value);
                     }
                     );
}

- (instancetype)aspectFit {
    self.contentMode = UIViewContentModeScaleAspectFit;
    return self;
}

- (instancetype)aspectFill {
    self.contentMode = UIViewContentModeScaleAspectFill;
    return self;
}

- (instancetype)centerMode {
    self.contentMode = UIViewContentModeCenter;
    return self;
}
@end
