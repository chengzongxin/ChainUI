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
- (instancetype)saveConstraintsAndReset:(id)null;

- (UIView *)getFirstItem:(id)null;
- (void)addLayoutAttribute:(NSLayoutAttribute)attribute;

- (void)updateSecondItem:(UIView *)item;
- (void)updateRelation:(NSLayoutRelation)relation;
- (void)updateMultipliers:(NSArray *)multipliers;
- (void)updateConstants:(NSArray *)array;
- (void)updateIdentifier:(NSString *)identifier;
- (void)updatePriority:(CGFloat)priority;

- (NSArray *)makeConstraints:(id)null;
- (NSArray *)remakeConstraints:(id)null;
- (NSArray *)updateConstraints:(id)null;

@end




@interface CUIConstraintMaker : NSObject

- (instancetype)initWithFirstItem:(UIView *)firstItem;

- (CUIConstraint *)makeCUIConstraintWithAttribute:(NSLayoutAttribute)attribute;

- (void)makeConstraints:(id)null;
- (void)remakeConstraints:(id)null;
- (void)updateConstraints:(id)null;

@end

NS_ASSUME_NONNULL_END
