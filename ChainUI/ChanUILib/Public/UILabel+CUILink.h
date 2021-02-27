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

@property (nonatomic, assign)   CGFloat nerLineGap;
@property (nonatomic, strong)   CUILinkHandler nerLinkHandler;
@property (nonatomic, readonly) NSLayoutManager *nerLayoutManager;


/**
 * Setting link selection style
 */
@property (nonatomic, strong)   UIColor *nerLinkSelectedColor;
@property (nonatomic, assign)   CGFloat nerLinkSelectedBorderRadius;

+ (void)setDefaultLinkSelectedBackgroundColor:(UIColor *)color borderRadius:(CGFloat)borderRadius;
@end

NS_ASSUME_NONNULL_END
