//
//  UILabel+CUILink.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>

typedef void (^CUILinkHandler)(NSString *text, NSRange range);
NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CUILink)

@property (nonatomic, assign)   CGFloat cuiLineGap;
@property (nonatomic, strong)   CUILinkHandler cuiLinkHandler;
@property (nonatomic, readonly) NSLayoutManager *cuiLayoutManager;


/**
 * Setting link selection style
 */
@property (nonatomic, strong)   UIColor *cuiLinkSelectedColor;
@property (nonatomic, assign)   CGFloat cuiLinkSelectedBorderRadius;

+ (void)setDefaultLinkSelectedBackgroundColor:(UIColor *)color borderRadius:(CGFloat)borderRadius;
@end

NS_ASSUME_NONNULL_END
