//
//  CUIUtils.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <Foundation/Foundation.h>
#import "CUITypeConverter.h"
NS_ASSUME_NONNULL_BEGIN

UIColor * CUIColorRepresentationOfValueOBJ(const char *type, const void *value);
UIColor * CUIColorWithObject(id object);


#define CUI_COLOR_VALUE_OBJ(x, ...)        ({ typeof(x) _ix_ = (x); CUIColorRepresentationOfValueOBJ(@encode(typeof(x)), &_ix_); })

@interface CUIUtils : NSObject

+ (UIColor *)colorWithColorObject:(id)object;
+ (UIFont *)fontWithFontObject:(id)object;
+ (UIImage *)imageWithImageObject:(id)object;
+ (id)imageOrColorWithObject:(id)object;

+ (UIImage *)onePointImageWithColor:(UIColor *)color;
+ (BOOL)colorHasAlphaChannel:(UIColor *)color;
+ (BOOL)imageHasAlphaChannel:(UIImage *)image;

+ (void)setTextWithStringObject:(id)stringObject forView:(UIView *)view;
+ (void)setPlaceholderWithStringObject:(id)stringObject forView:(UIView *)view;

+ (void)updateViewSizeIfNeed:(UIView *)view withImage:(UIImage *)image;
+ (BOOL)limitTextInput:(id<UITextInput>)textInput withLength:(NSInteger)maxLength;

+ (void)applyStyleObject:(id)value toItem:(id)item;
+ (NSArray *)numberArrayFromFLoatList:(CUIFloatList)value;

+ (UIViewController *)getVisibleViewController;

@end

NS_ASSUME_NONNULL_END
