//
//  CUIConstraint+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIConstraint+Chainable.h"
#import "CUIUtils.h"


#define SYNTHESIZE_CONSTRAINT_PROP(x, y)\
- (instancetype)x {\
    [self addLayoutAttribute:NSLayoutAttribute##y];\
    return self;\
}


@implementation CUIConstraint (Chainable)

SYNTHESIZE_CONSTRAINT_PROP(left, Left);
SYNTHESIZE_CONSTRAINT_PROP(right, Right);
SYNTHESIZE_CONSTRAINT_PROP(top, Top);
SYNTHESIZE_CONSTRAINT_PROP(bottom, Bottom);
SYNTHESIZE_CONSTRAINT_PROP(leading, Leading);
SYNTHESIZE_CONSTRAINT_PROP(trailing, Trailing);
SYNTHESIZE_CONSTRAINT_PROP(width, Width);
SYNTHESIZE_CONSTRAINT_PROP(height, Height);
SYNTHESIZE_CONSTRAINT_PROP(centerX, CenterX);
SYNTHESIZE_CONSTRAINT_PROP(centerY, CenterY);
SYNTHESIZE_CONSTRAINT_PROP(baseline, Baseline);
SYNTHESIZE_CONSTRAINT_PROP(firstBaseline, FirstBaseline);
SYNTHESIZE_CONSTRAINT_PROP(leftMargin, LeftMargin);
SYNTHESIZE_CONSTRAINT_PROP(rightMargin, RightMargin);
SYNTHESIZE_CONSTRAINT_PROP(topMargin, TopMargin);
SYNTHESIZE_CONSTRAINT_PROP(bottomMargin, BottomMargin);
SYNTHESIZE_CONSTRAINT_PROP(leadingMargin, LeadingMargin);
SYNTHESIZE_CONSTRAINT_PROP(trailingMargin, TrailingMargin);
SYNTHESIZE_CONSTRAINT_PROP(centerXWithinMargins, CenterXWithinMargins);
SYNTHESIZE_CONSTRAINT_PROP(centerYWithinMargins, CenterYWithinMargins);

- (instancetype)center {
    return self.centerX.centerY;
}

- (instancetype)size {
    return self.width.height;
}

- (instancetype)edge {
    return self.top.left.bottom.right;
}


- (CUIChainableCUIConstraintFloatListBlock)multipliers {
    CUI_FLOAT_LIST_BLOCK([self updateMultipliers:[CUIUtils numberArrayFromFLoatList:value]]);
}

- (CUIChainableCUIConstraintFloatListBlock)constants {
    CUI_FLOAT_LIST_BLOCK([self updateConstants:[CUIUtils numberArrayFromFLoatList:value]]);
}

- (CUIChainableCUIConstraintFloatBlock)priority {
    CUI_FLOAT_BLOCK([self updatePriority:value]);
}

- (CUIChainableCUIConstraintObjectBlock)identifier {
    CUI_OBJECT_BLOCK([self updateIdentifier:value]);
}

- (CUIChainableCUIConstraintObjectBlock)view {
    CUI_OBJECT_BLOCK([self updateSecondItem:value]);
}

- (instancetype)self {
    [self updateSecondItem:[self getFirstItem:nil]];
    return self;
}

- (instancetype)superview {
    [self updateSecondItem:[self getFirstItem:nil].superview];
    return self;
}

- (instancetype)equal {
    [self updateRelation:NSLayoutRelationEqual];
    return self;
}

- (instancetype)lessEqual {
    [self updateRelation:NSLayoutRelationLessThanOrEqual];
    return self;
}

- (instancetype)greaterEqual {
    [self updateRelation:NSLayoutRelationGreaterThanOrEqual];
    return self;
}

- (instancetype)And {
    return [self saveConstraintsAndReset:nil];
}

- (void (^)(void))End {
    return ^{};
}

- (NSArray *(^)(void))make {
    return ^{
        return [self makeConstraints:nil];
    };
}

- (NSArray *(^)(void))remake {
    return ^{
        return [self remakeConstraints:nil];
    };
}

- (NSArray *(^)(void))update {
    return ^{
        return [self updateConstraints:nil];
    };
}

@end





#define SYNTHESIZE_MAKER_PROP(x, y)\
- (CUIConstraint *)x {\
    return [self makeCUIConstraintWithAttribute:NSLayoutAttribute##y];\
}

@implementation CUIConstraintMaker (CUIChainable)

SYNTHESIZE_MAKER_PROP(left, Left);
SYNTHESIZE_MAKER_PROP(right, Right);
SYNTHESIZE_MAKER_PROP(top, Top);
SYNTHESIZE_MAKER_PROP(bottom, Bottom);
SYNTHESIZE_MAKER_PROP(leading, Leading);
SYNTHESIZE_MAKER_PROP(trailing, Trailing);
SYNTHESIZE_MAKER_PROP(width, Width);
SYNTHESIZE_MAKER_PROP(height, Height);
SYNTHESIZE_MAKER_PROP(centerX, CenterX);
SYNTHESIZE_MAKER_PROP(centerY, CenterY);
SYNTHESIZE_MAKER_PROP(baseline, Baseline);
SYNTHESIZE_MAKER_PROP(firstBaseline, FirstBaseline);
SYNTHESIZE_MAKER_PROP(leftMargin, LeftMargin);
SYNTHESIZE_MAKER_PROP(rightMargin, RightMargin);
SYNTHESIZE_MAKER_PROP(topMargin, TopMargin);
SYNTHESIZE_MAKER_PROP(bottomMargin, BottomMargin);
SYNTHESIZE_MAKER_PROP(leadingMargin, LeadingMargin);
SYNTHESIZE_MAKER_PROP(trailingMargin, TrailingMargin);
SYNTHESIZE_MAKER_PROP(centerXWithinMargins, CenterXWithinMargins);
SYNTHESIZE_MAKER_PROP(centerYWithinMargins, CenterYWithinMargins);

- (CUIConstraint *)center {
    return self.centerX.centerY;
}

- (CUIConstraint *)size {
    return self.width.height;
}

- (CUIConstraint *)edge {
    return self.top.left.bottom.right;
}

@end
