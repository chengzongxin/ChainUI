//
//  CUIPrivates.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <Foundation/Foundation.h>
#import "CUIDefs.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CUIPrivate)

+ (BOOL)cui_swizzleMethod:(SEL)selector1 withMethod:(SEL)selector2;
+ (BOOL)cui_swizzleClassMethod:(SEL)selector1 withMethod:(SEL)selector2;

- (id)cui_associatedObjectForKey:(NSString *)key;
- (void)cui_setAssociatedObject:(id)object forKey:(NSString *)key;

- (id)cui_weakAssociatedObjectForKey:(NSString *)key;
- (void)cui_setWeakAssociatedObject:(id)object forKey:(NSString *)key;

- (NSArray *)cui_allPropertyNames;
- (NSArray *)cui_allIvarNames;
- (NSArray *)cui_allMethodNames;

@end


@interface NSString (CUIPrivate)

- (NSRange)cui_fullRange;

- (NSString *)cui_md5;
- (NSString *)cui_base64;
- (NSString *)cui_urlEncode;
- (NSString *)cui_urlDecode;
- (NSString *)cui_trim;

@end



#define CUILinkAttributeName            @"CUILink"
#define CUILinkAttributeValue           @"CUILinkValue"

#define CUIFixLineSpacingAttributeName  @"CUIFixLineSpacingIssue"
#define CUIFixLineSpacingAttributeValue @"Fix single line Label with lineSpacing issue"

@interface NSMutableAttributedString (CUIPrivate)

@property (nonatomic, assign) BOOL cuiAddAttributeIfNotExists;
@property (nonatomic, assign) BOOL cuiIsJustSettingEffectedRanges;
@property (nonatomic, strong) NSMutableIndexSet *cuiEffectedRanges;

+ (instancetype)cui_attributedStringWithSubstrings:(NSArray *)substrings;

- (void)cui_applyAttribute:(NSString *)name withValue:(id)value;
- (void)cui_addAttributeIfNotExist:(NSString *)name value:(id)value range:(NSRange)range;
- (void)cui_setParagraphStyleValue:(id)value forKey:(NSString *)key;
- (void)cui_setParagraphStyleValue:(id)value forKey:(NSString *)key range:(NSRange)range;

@end




@interface UIView (CUIPriavte)

@property (nonatomic, assign) UIEdgeInsets cuiTouchInsets;

- (CGSize)cui_fittingSize;
- (UIImage *)cui_snapShot;

- (void)cui_addChild:(id)value;
- (instancetype)cui_updateFrame:(CUIRect)rect;

+ (instancetype)cui_littleHigherHuggingAndResistanceView;

@end



@interface UIImageView (CUIPriavte)

@end



@interface UIButton (CUIPriavte)

@property (nonatomic, assign) CGFloat cuiGap;
@property (nonatomic, assign) UIEdgeInsets cuiInsets;

+ (instancetype)cui_littleHigherHuggingAndResistanceButton;
- (instancetype)cui_reverseButton;

@end




@interface UITextField (CUIPriavte)

@property (nonatomic, assign) NSInteger cuiMaxLength;
@property (nonatomic, assign) UIEdgeInsets cuiContentEdgeInsets;
@property (nonatomic, strong) CUIObjectBlock cuiTextChangeBlock;
@property (nonatomic, strong) CUIObjectBlock cuiEndOnExitBlock;


+ (instancetype)cui_autoEnableReturnKeyTextField;

@end



@interface UITextView (CUIPriavte)

@property (nonatomic, assign) NSInteger cuiMaxLength;
@property (nonatomic, strong) CUIObjectBlock cuiTextChangeBlock;

- (void)cui_setPlaceholderText:(id)stringObject;

@end



@interface UISlider (CUIPrivate)

@property (nonatomic, strong) NSNumber *cuiTrackHeight;
@property (nonatomic, assign) UIEdgeInsets cuiThumbInsets;

@end



@interface UIPageControl (CUIPriavte)

@end



@interface UISwitch (CUIPriavte)

@end


@interface UIStepper (CUIPriavte)

@end


@interface UIVisualEffectView (CUIPriavte)

@property (nonatomic, strong) UIVisualEffectView *cuiVibrancyEffectView;

- (void)cui_addVibrancyChild:(id)object;

@end


@interface UISegmentedControl (CUIPriavte)

+ (instancetype)cui_segmentedControlWithItems:(NSArray *)items;

@end




@interface UIControl (CUIPriavte)

- (instancetype)cui_registerOnChangeHandlerWithTarget:(id)target object:(id)object;

@end


@protocol UIControlPrivateProtocol <NSObject>

- (void)cui_control_onChangeHandler;

@end


@interface UIColor (CUIPrivate)

- (UIColor *)cui_colorWithHueOffset:(CGFloat)ho saturationOffset:(CGFloat)so brightnessOffset:(CGFloat)bo;

@end


@interface UIImage (CUIPrivate)

- (UIImage *)cui_stretchableImage;


//https://developer.apple.com/library/content/samplecode/UIImageEffects/Introduction/Intro.html#//apple_ref/doc/uid/DTS40013396

//| ----------------------------------------------------------------------------
//! Applies a blur, tint color, and saturation adjustment to @a inputImage,
//! optionally within the area specified by @a maskImage.
//!
//! @param  blurRadius
//!         The radius of the blur in points.
//! @param  tintColor
//!         An optional UIColor object that is uniformly blended with the
//!         result of the blur and saturation operations.  The alpha channel
//!         of this color determines how strong the tint is.
//! @param  saturationDeltaFactor
//!         A value of 1.0 produces no change in the resulting image.  Values
//!         less than 1.0 will desaturation the resulting image while values
//!         greater than 1.0 will have the opposite effect.
//! @param  maskImage
//!         If specified, @a inputImage is only modified in the area(s) defined
//!         by this mask.  This must be an image mask or it must meet the
//!         requirements of the mask parameter of CGContextClipToMask.

- (UIImage *)cui_blueWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
