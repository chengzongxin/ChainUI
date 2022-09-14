//
//  CUIConstraint.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIConstraint.h"
#import <objc/objc.h>
#import <objc/runtime.h>


@interface UIView (CUIConstraintPrivate)

@property (nonatomic, readonly) NSHashTable *cuiMadeConstraints;

@end


@implementation UIView (CUIConstraintPrivate)

- (NSHashTable *)cuiMadeConstraints {
    NSHashTable *constraints = objc_getAssociatedObject(self, _cmd);
    if (!constraints) {
        constraints = [NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, _cmd, constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return constraints;
}

- (NSLayoutConstraint *)cui_madeConstraintSimilarTo:(NSLayoutConstraint *)c2 {
    for (NSLayoutConstraint *c1 in self.cuiMadeConstraints) {
        if (c1.firstItem == c2.firstItem &&
            c1.secondItem == c2.secondItem &&
            c1.firstAttribute == c2.firstAttribute &&
            c1.secondAttribute == c2.secondAttribute &&
            c1.relation == c2.relation &&
            c1.priority == c2.priority &&
            c1.multiplier == c2.multiplier)
            return c1;
    }
    return nil;
}

- (void)cui_addMadeConstraints:(NSArray *)constraints {
    for (NSLayoutConstraint *c in constraints) {
        [self.cuiMadeConstraints addObject:c];
    }
}

- (void)cui_removeAllMadeConstraints {
    for (NSLayoutConstraint *c in self.cuiMadeConstraints) { c.active = NO; }
    [self.cuiMadeConstraints removeAllObjects];
}

@end





@interface CUIConstraint ()

@property (nonatomic, strong) UIView *firstItem;
@property (nonatomic, strong) UIView *secondItem;
@property (nonatomic, strong) NSMutableArray *firstItemAttributes;
@property (nonatomic, strong) NSMutableArray *secondItemAttributes;

@property (nonatomic, strong) NSArray *multiplierValues;
@property (nonatomic, strong) NSArray *constantValues;
@property (nonatomic, strong) NSString *identifierValue;

@property (nonatomic, assign) NSLayoutRelation relationValue;
@property (nonatomic, assign) CGFloat priorityValue;

@property (nonatomic, strong) NSMutableArray *layoutConstraints;

@end


@implementation CUIConstraint


- (NSArray *)activateConstraints {
    [NSLayoutConstraint activateConstraints:self.layoutConstraints];
    [self.firstItem cui_addMadeConstraints:self.layoutConstraints];
    return [self.layoutConstraints copy];
}

- (NSArray *)makeConstraints:(id)null {
    [self generateConstraints];
    return [self activateConstraints];
}

- (NSArray *)updateConstraints:(id)null {
    [self generateConstraints];
    NSMutableArray *newConstraints = [NSMutableArray array];
    
    for (NSLayoutConstraint *constraint in self.layoutConstraints) {
        NSLayoutConstraint *oldConstraint = [self.firstItem cui_madeConstraintSimilarTo:constraint];
        if (oldConstraint) {
            oldConstraint.constant = constraint.constant;
            [newConstraints addObject:oldConstraint];
        } else {
            [newConstraints addObject:constraint];
        }
    }
    
    self.layoutConstraints = newConstraints;
    return [self activateConstraints];
}

- (NSArray *)remakeConstraints:(id)null {
    [self.firstItem cui_removeAllMadeConstraints];
    return [self makeConstraints:nil];
}

- (void)generateConstraints {
    for (int i = 0; i < self.firstItemAttributes.count; ++i) {
        NSLayoutAttribute att1 = (NSLayoutAttribute)[self.firstItemAttributes[i] integerValue];
        NSLayoutAttribute att2 = NSLayoutAttributeNotAnAttribute;
        
        if (i < self.secondItemAttributes.count) {
            att2 = (NSLayoutAttribute)[self.secondItemAttributes[i] integerValue];
        }
        
        CGFloat constant = 0;
        CGFloat multiplier = 1;
        
        if (i < self.constantValues.count) {
            constant = [self.constantValues[i] floatValue];
        } else if (self.constantValues.lastObject) {
            constant = [self.constantValues.lastObject floatValue];
        }
        
        if (i < self.multiplierValues.count) {
            multiplier = [self.multiplierValues[i] floatValue];
        } else if (self.multiplierValues.count) {
            multiplier = [self.multiplierValues.lastObject floatValue];
        }
        
        if (multiplier == 0) {
            multiplier = 1;    //multiplier can not be 0
        }
        
        id secondItem = self.secondItem;
        
        if (!secondItem) {
            if (att1 == NSLayoutAttributeWidth || att1 == NSLayoutAttributeHeight) {
                if (att2 == NSLayoutAttributeWidth || att2 == NSLayoutAttributeHeight) {
                    secondItem = self.firstItem;
                }
            } else {
                secondItem = self.firstItem.superview;
            }
        }
        
        if (att2 == NSLayoutAttributeNotAnAttribute) {
            att2 = att1;
        }
        
        NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:self.firstItem
                                                             attribute:att1
                                                             relatedBy:self.relationValue
                                                                toItem:secondItem
                                                             attribute:att2
                                                            multiplier:multiplier
                                                              constant:constant];
        
        c.priority = self.priorityValue;
        c.identifier = self.identifierValue;
        
        [self.layoutConstraints addObject:c];
    }
}

- (UIView *)getFirstItem:(id)null {
    return self.firstItem;
}

- (void)updateSecondItem:(UIView *)item {
    self.secondItem = item;
    if (!self.secondItemAttributes) {
        self.secondItemAttributes = [NSMutableArray array];
    }
}

- (void)updateRelation:(NSLayoutRelation)relation {
    self.relationValue = relation;
    if (!self.secondItemAttributes) {
        self.secondItemAttributes = [NSMutableArray array];
    }
}

- (void)updateConstants:(NSArray *)array {
    self.constantValues = array;
}

- (void)updateIdentifier:(NSString *)identifier {
    self.identifierValue = identifier;
}

- (void)updateMultipliers:(NSArray *)multipliers {
    self.multiplierValues = multipliers;
}

- (void)updatePriority:(CGFloat)priority {
    self.priorityValue = priority;
}

- (void)addLayoutAttribute:(NSLayoutAttribute)attribute {
    NSMutableArray *targetArray = (self.secondItemAttributes?: self.firstItemAttributes);
    [targetArray addObject:@(attribute)];
}

- (instancetype)saveConstraintsAndReset:(id)null {
    [self generateConstraints];
    [self reset];
    return self;
}

- (void)reset {
    self.secondItem = nil;
    self.constantValues = nil;
    self.identifierValue = nil;
    self.secondItemAttributes = nil;
    self.firstItemAttributes = [NSMutableArray array];
    
    self.relationValue = NSLayoutRelationEqual;
    self.priorityValue = UILayoutPriorityRequired;
}

- (instancetype)initWithFirstItem:(UIView *)firstItem {
    self = [super init];
    self.firstItem = firstItem;
    self.layoutConstraints = [NSMutableArray array];
    self.firstItem.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self reset];
    return self;
}

@end





@interface CUIConstraintMaker ()

@property (nonatomic, strong) UIView *firstItem;
@property (nonatomic, strong) NSMutableArray *cuiConstraints;

@end


@implementation CUIConstraintMaker


- (void)makeConstraints:(id)null {
    for (CUIConstraint *c in self.cuiConstraints) {
        [c makeConstraints:nil];
    }
}

- (void)remakeConstraints:(id)null {
    for (CUIConstraint *c in self.cuiConstraints) {
        [c remakeConstraints:nil];
    }
}

- (void)updateConstraints:(id)null {
    for (CUIConstraint *c in self.cuiConstraints) {
        [c updateConstraints:nil];
    }
}

- (CUIConstraint *)makeCUIConstraintWithAttribute:(NSLayoutAttribute)attribute {
    CUIConstraint *c = [[CUIConstraint alloc] initWithFirstItem:self.firstItem];
    [c addLayoutAttribute:attribute];
    [self.cuiConstraints addObject:c];
    return c;
}

- (instancetype)initWithFirstItem:(UIView *)firstItem {
    self = [super init];
    self.firstItem = firstItem;
    self.cuiConstraints = [NSMutableArray array];
    return self;
}

@end

