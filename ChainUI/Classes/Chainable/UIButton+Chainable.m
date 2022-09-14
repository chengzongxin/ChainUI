//
//  UIButton+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "UIButton+Chainable.h"
#import "UIFont+Chainable.h"
#import "UIColor+Chainable.h"
#import "UIImage+Chainable.h"


@implementation UIButton (Chainable)

- (CUIChainableUIButtonObjectBlock)str {
    CUI_OBJECT_BLOCK([CUIUtils setTextWithStringObject:value forView:self]);
}

- (CUIChainableUIButtonObjectBlock)fnt {
    CUI_OBJECT_BLOCK(self.titleLabel.font = Fnt(value));
}

- (CUIChainableUIButtonObjectBlock)color {
    CUI_OBJECT_BLOCK([self setTitleColor:Color(value) forState:UIControlStateNormal]);
}

- (CUIChainableUIButtonObjectBlock)highColor {
    CUI_OBJECT_BLOCK([self setTitleColor:Color(value) forState:UIControlStateHighlighted]);
}

- (CUIChainableUIButtonObjectBlock)selectedColor {
    CUI_OBJECT_BLOCK([self setTitleColor:Color(value) forState:UIControlStateSelected]);
}

- (CUIChainableUIButtonObjectBlock)disabledColor {
    CUI_OBJECT_BLOCK([self setTitleColor:Color(value) forState:UIControlStateDisabled]);
}

- (CUIChainableUIButtonObjectBlock)img {
    CUI_OBJECT_BLOCK(
                     id image = Img(value);
                     [self setImage:image forState:UIControlStateNormal];
                     [CUIUtils updateViewSizeIfNeed:self withImage:image];
                     );
}

- (CUIChainableUIButtonObjectBlock)highImg {
    CUI_OBJECT_BLOCK([self setImage:Img(value) forState:UIControlStateHighlighted]);
}

- (CUIChainableUIButtonObjectBlock)selectedImg {
    CUI_OBJECT_BLOCK([self setImage:Img(value) forState:UIControlStateSelected]);
}

- (CUIChainableUIButtonObjectBlock)disabledImg {
    CUI_OBJECT_BLOCK([self setImage:Img(value) forState:UIControlStateDisabled]);
}

- (CUIChainableUIButtonObjectBlock)bgImg {
    CUI_OBJECT_BLOCK(
                     id image = Img(value);
                     [self setBackgroundImage:image forState:UIControlStateNormal];
                     [CUIUtils updateViewSizeIfNeed:self withImage:image];
                     );
}

- (CUIChainableUIButtonObjectBlock)highBgImg {
    CUI_OBJECT_BLOCK(
                     id image = Img(value);
                     [self setBackgroundImage:image forState:UIControlStateHighlighted];
                     );
}

- (CUIChainableUIButtonObjectBlock)selectedBgImg {
    CUI_OBJECT_BLOCK(
                     id image = Img(value);
                     [self setBackgroundImage:image forState:UIControlStateSelected];
                     );
}

- (CUIChainableUIButtonObjectBlock)disabledBgImg {
    CUI_OBJECT_BLOCK(
                     id image = Img(value);
                     [self setBackgroundImage:image forState:UIControlStateDisabled];
                     );
}

- (CUIChainableUIButtonFloatBlock)gap {
    CUI_FLOAT_BLOCK(
                    self.cuiGap = value;
                    CGFloat halfGap = value / 2;
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, halfGap, 0, -halfGap)];
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -halfGap, 0, halfGap)];
                    
                    UIEdgeInsets insets = self.cuiInsets;
                    insets.left += halfGap;
                    insets.right += halfGap;
                    self.contentEdgeInsets = insets;
                    );
}

- (CUIChainableUIButtonInsetsBlock)insets {
    CUI_INSETS_BLOCK(
                     CGFloat halfGap = self.cuiGap / 2;
                     self.cuiInsets = value;
                     
                     UIEdgeInsets insets = value;
                     insets.left += halfGap;
                     insets.right += halfGap;
                     self.contentEdgeInsets = insets;
                     );
}

- (instancetype)reversed {
    CATransform3D t = CATransform3DMakeScale(-1, 1, 1);
    self.layer.sublayerTransform = t;
    self.imageView.layer.transform = t;
    self.titleLabel.layer.transform = t;
    return self;
}

- (instancetype)multiline {
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.numberOfLines = 0;
    return self;
}

- (instancetype)adjustDisabled {
    self.adjustsImageWhenHighlighted = NO;
    return self;
}
@end
