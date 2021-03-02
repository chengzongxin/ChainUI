//
//  CUIConstraint.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CUIConstraint : NSObject

/*
 Use methods to prevent pulluting auto-completion.
 */

- (instancetype)initWithFirstItem:(UIView *)firstItem;
- (instancetype)saveConstraintsAndReset:(__nullable id)null;

- (UIView *)getFirstItem:(__nullable id)null;
- (void)addLayoutAttribute:(NSLayoutAttribute)attribute;

- (void)updateSecondItem:(UIView *)item;
- (void)updateRelation:(NSLayoutRelation)relation;
- (void)updateMultipliers:(NSArray *)multipliers;
- (void)updateConstants:(NSArray *)array;
- (void)updateIdentifier:(NSString *)identifier;
- (void)updatePriority:(CGFloat)priority;

- (NSArray *)makeConstraints:(__nullable id)null;
- (NSArray *)remakeConstraints:(__nullable id)null;
- (NSArray *)updateConstraints:(__nullable id)null;

@end




@interface CUIConstraintMaker : NSObject

- (instancetype)initWithFirstItem:(UIView *)firstItem;

- (CUIConstraint *)makeCUIConstraintWithAttribute:(NSLayoutAttribute)attribute;

- (void)makeConstraints:(__nullable id)null;
- (void)remakeConstraints:(__nullable id)null;
- (void)updateConstraints:(__nullable id)null;

@end

NS_ASSUME_NONNULL_END
