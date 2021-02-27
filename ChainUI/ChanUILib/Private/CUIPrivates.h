//
//  CUIPrivates.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CUIPrivate)

+ (BOOL)ner_swizzleMethod:(SEL)selector1 withMethod:(SEL)selector2;
+ (BOOL)ner_swizzleClassMethod:(SEL)selector1 withMethod:(SEL)selector2;

- (id)ner_associatedObjectForKey:(NSString *)key;
- (void)ner_setAssociatedObject:(id)object forKey:(NSString *)key;

- (id)ner_weakAssociatedObjectForKey:(NSString *)key;
- (void)ner_setWeakAssociatedObject:(id)object forKey:(NSString *)key;

- (NSArray *)ner_allPropertyNames;
- (NSArray *)ner_allIvarNames;
- (NSArray *)ner_allMethodNames;

@end


@interface NSString (CUIPrivate)

- (NSRange)ner_fullRange;

- (NSString *)ner_md5;
- (NSString *)ner_base64;
- (NSString *)ner_urlEncode;
- (NSString *)ner_urlDecode;
- (NSString *)ner_trim;

@end



#define CUILinkAttributeName            @"CUILink"
#define CUILinkAttributeValue           @"CUILinkValue"

#define CUIFixLineSpacingAttributeName  @"CUIFixLineSpacingIssue"
#define CUIFixLineSpacingAttributeValue @"Fix single line Label with lineSpacing issue"

@interface NSMutableAttributedString (CUIPrivate)

@property (nonatomic, assign) BOOL nerAddAttributeIfNotExists;
@property (nonatomic, assign) BOOL nerIsJustSettingEffectedRanges;
@property (nonatomic, strong) NSMutableIndexSet *nerEffectedRanges;

+ (instancetype)ner_attributedStringWithSubstrings:(NSArray *)substrings;

- (void)ner_applyAttribute:(NSString *)name withValue:(id)value;
- (void)ner_addAttributeIfNotExist:(NSString *)name value:(id)value range:(NSRange)range;
- (void)ner_setParagraphStyleValue:(id)value forKey:(NSString *)key;
- (void)ner_setParagraphStyleValue:(id)value forKey:(NSString *)key range:(NSRange)range;

@end




@interface UIView (CUIPriavte)

@property (nonatomic, assign) UIEdgeInsets nerTouchInsets;

- (CGSize)ner_fittingSize;
- (UIImage *)ner_snapShot;

- (void)ner_addChild:(id)value;
- (instancetype)ner_updateFrame:(CUIRect)rect;

+ (instancetype)ner_littleHigherHuggingAndResistanceView;

@end



@interface UIImageView (CUIPriavte)

@end



@interface UIButton (CUIPriavte)

@property (nonatomic, assign) CGFloat nerGap;
@property (nonatomic, assign) UIEdgeInsets nerInsets;

+ (instancetype)ner_littleHigherHuggingAndResistanceButton;
- (instancetype)ner_reverseButton;

@end




@interface UITextField (CUIPriavte)

@property (nonatomic, assign) NSInteger nerMaxLength;
@property (nonatomic, assign) UIEdgeInsets nerContentEdgeInsets;
@property (nonatomic, strong) CUIObjectBlock nerTextChangeBlock;
@property (nonatomic, strong) CUIObjectBlock nerEndOnExitBlock;


+ (instancetype)ner_autoEnableReturnKeyTextField;

@end



@interface UITextView (CUIPriavte)

@property (nonatomic, assign) NSInteger nerMaxLength;
@property (nonatomic, strong) CUIObjectBlock nerTextChangeBlock;

- (void)ner_setPlaceholderText:(id)stringObject;

@end



@interface UISlider (CUIPrivate)

@property (nonatomic, strong) NSNumber *nerTrackHeight;
@property (nonatomic, assign) UIEdgeInsets nerThumbInsets;

@end



@interface UIPageControl (CUIPriavte)

@end



@interface UISwitch (CUIPriavte)

@end


@interface UIStepper (CUIPriavte)

@end


@interface UIVisualEffectView (CUIPriavte)

@property (nonatomic, strong) UIVisualEffectView *nerVibrancyEffectView;

- (void)ner_addVibrancyChild:(id)object;

@end


@interface UISegmentedControl (CUIPriavte)

+ (instancetype)ner_segmentedControlWithItems:(NSArray *)items;

@end




@interface UIControl (CUIPriavte)

- (instancetype)ner_registerOnChangeHandlerWithTarget:(id)target object:(id)object;

@end


@protocol UIControlPrivateProtocol <NSObject>

- (void)ner_control_onChangeHandler;

@end


@interface UIColor (CUIPrivate)

- (UIColor *)ner_colorWithHueOffset:(CGFloat)ho saturationOffset:(CGFloat)so brightnessOffset:(CGFloat)bo;

@end


@interface UIImage (CUIPrivate)

- (UIImage *)ner_stretchableImage;


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

- (UIImage *)ner_blueWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
