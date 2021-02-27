//
//  CUIStyle.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>
#import "CUIDefs.h"

NS_ASSUME_NONNULL_BEGIN

@interface CUIStyle : NSObject

+ (instancetype)styleWithKey:(id <NSCopying>)key;
+ (instancetype)createStyleWithKey:(id <NSCopying>)key;
+ (instancetype)createStyleWithKeys:(NSArray *)keys;

- (void)setObjectValue:(id)value forKey:(NSString *)Key;
- (void)setIntValue:(NSInteger)value forKey:(NSString *)key;
- (void)setFloatValue:(CGFloat)value forKey:(NSString *)key;
- (void)setPointValue:(CGPoint)value forKey:(NSString *)key;
- (void)setSizeValue:(CGSize)value forKey:(NSString *)key;
- (void)setRectValue:(CGRect)value forKey:(NSString *)key;
- (void)setFloatListValue:(CUIFloatList)flostList forKey:(NSString *)key;

- (void)addMethodWithName:(NSString *)name;

- (void)applyToItem:(id)item;
@end

NS_ASSUME_NONNULL_END
