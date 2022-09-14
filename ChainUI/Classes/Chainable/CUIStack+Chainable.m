//
//  CUIStack+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIStack+Chainable.h"

@implementation CUIStack (Chainable)

- (CUIChainableCUIStackFloatBlock)gap {
    CUI_FLOAT_BLOCK(self.spacing = value);
}

- (CUIChainableCUIStackObjectBlock)addChild{
    CUI_OBJECT_BLOCK(
                     if ([value isKindOfClass:NSArray.class]) {
                        for (UIView *item in value) {
                            [self addArrangedSubview:item];
                        }
                    }
                     );
}

- (instancetype)topAlignment {
    self.alignment = CUIStackAlignmentTop;
    return self;
}

- (instancetype)leftAlignment {
    self.alignment = CUIStackAlignmentLeading;
    return self;
}

- (instancetype)centerAlignment {
    self.alignment = CUIStackAlignmentCenter;
    return self;
}

- (instancetype)bottomAlignment {
    self.alignment = CUIStackAlignmentBotttom;
    return self;
}

- (instancetype)rightAlignment {
    self.alignment = CUIStackAlignmentTrailing;
    return self;
}

- (instancetype)baselineAlignment {
    self.alignment = CUIStackAlignmentBaseline;
    return self;
}

- (instancetype)firstBaselineAlignment {
    self.alignment = CUIStackAlignmentFirstBaseline;
    return self;
}
@end
