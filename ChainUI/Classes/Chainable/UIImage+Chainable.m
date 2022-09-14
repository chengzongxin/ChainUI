//
//  UIImage+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIImage+Chainable.h"
#import "CUIPrivates.h"

@implementation UIImage (Chainable)

- (CUIChainableUIImageRectBlock)subImg {
    CUI_RECT_BLOCK(
                   CGRect rect = value.value;
                   rect.origin.x *= self.scale;
                   rect.origin.y *= self.scale;
                   rect.size.width *= self.scale;
                   rect.size.height *= self.scale;
                   
                   CGImageRef ref = CGImageCreateWithImageInRect(self.CGImage, rect);
                   UIImage *image =  [UIImage imageWithCGImage:ref scale:self.scale orientation:self.imageOrientation];
                   CGImageRelease(ref);
                   return image;
                   );
}

- (CUIChainableUIImageTwoFloatBlock)resize {
    CUI_TWO_FLOAT_BLOCK(
                        CGRect rect = CGRectMake(0, 0, value1, value2);
                        BOOL hasAlpha = [CUIUtils imageHasAlphaChannel:self];
                   
                        UIGraphicsBeginImageContextWithOptions(rect.size, !hasAlpha, self.scale);
                        [self drawInRect:rect];
                        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        return newImage;
    );
}

- (CUIChainableUIImageInsetsBlock)stretchInsets {
    CUI_INSETS_BLOCK(return [self resizableImageWithCapInsets:value resizingMode:UIImageResizingModeStretch]);
}

- (CUIChainableUIImageInsetsBlock)tileInsets {
    CUI_INSETS_BLOCK(return [self resizableImageWithCapInsets:value resizingMode:UIImageResizingModeTile]);
}

- (CUIChainableUIImageFloatBlock)blur {
    CUI_FLOAT_BLOCK(return [self cui_blueWithRadius:value tintColor:nil saturationDeltaFactor:1 maskImage:nil]);
}

- (instancetype)stretchable {
    return [self cui_stretchableImage];
}

- (instancetype)templates {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (instancetype)original {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
