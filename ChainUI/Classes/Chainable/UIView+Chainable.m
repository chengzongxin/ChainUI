//
//  UIView+ChainUI.m
//  Demo
//
//  Created by Joe.cheng on 2021/2/25.
//

#import "UIView+Chainable.h"
#import "UIColor+Chainable.h"
#import "CUIConstraint+Chainable.h"
#import "CUIUtils.h"
#import "CUIPrivates.h"

@implementation UIView (Chainable)

- (CUIChainableUIViewIntBlock)tg {
    CUI_INT_BLOCK(self.tag = value);
}

- (CUIChainableUIViewFloatBlock)opacity {
    CUI_FLOAT_BLOCK(self.alpha = value);
}

- (CUIChainableUIViewObjectBlock)tint {
    CUI_OBJECT_BLOCK(self.tintColor = Color(value));
}

- (CUIChainableUIViewObjectBlock)bgColor {
    CUI_OBJECT_BLOCK(self.backgroundColor = Color(value));
}

- (CUIChainableUIViewFloatBlock)borderRadius {
    CUI_FLOAT_BLOCK(
                    self.layer.cornerRadius = value;
                    if (self.layer.shadowOpacity == 0) {
                        self.layer.masksToBounds = YES;
                    }
                    );
}

- (CUIChainableUIViewFloatObjectListBlock)border {
    CUI_FLOAT_OBJECT_LIST_BLOCK(
                                self.layer.borderWidth = value;
                                if (arguments.firstObject) {
                                    self.layer.borderColor = Color(arguments.firstObject).CGColor;
                                }
                                );
}

- (CUIChainableUIViewFloatListBlock)shadow {
    CUI_FLOAT_LIST_BLOCK(
                         self.layer.masksToBounds = NO;
                         self.layer.shadowOpacity = value.f1;
                         
                         if (CGSizeEqualToSize(self.layer.shadowOffset, CGSizeMake(0, -3))) {
                             self.layer.shadowOffset = CGSizeMake(0, 3);
                         }
                         
                         if (value.validCount >= 2) {
                             self.layer.shadowRadius = value.f2;
                         }
                         
                         CGSize offset = self.layer.shadowOffset;
                         
                         if (value.validCount >= 3) {
                             offset.width = value.f3;
                         }
                         if (value.validCount >= 4) {
                             offset.height = value.f4;
                         }
                         
                         self.layer.shadowOffset = offset;
    );
}

- (CUIChainableUIViewObjectBlock)styles {
    CUI_OBJECT_BLOCK([CUIUtils applyStyleObject:value toItem:self];);
}

- (CUIChainableUIViewInsetsBlock)touchInsets {
    CUI_INSETS_BLOCK(self.cuiTouchInsets = value);
}

- (CUIChainableUIViewCallbackBlock)onClick {
    CUI_CALLBACK_BLOCK(
                        if (CUI_IS_BLOCK(object)) {
                            SEL action = @selector(cui_view_onClickHandler);
                            objc_setAssociatedObject(self, action, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                            [self cui_view_addClickHandler:self action:action];
                        } else {
                            SEL action = NSSelectorFromString(object);
                            [self cui_view_addClickHandler:target action:action];
                        }
    );
}

- (void)cui_view_addClickHandler:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        id reg = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:reg];
    }
}

- (void)cui_view_onClickHandler {
    id block = objc_getAssociatedObject(self, _cmd);
    if (block) ((CUIObjectBlock)block)(self);
}

- (CUIChainableUIViewObjectBlock)addTo {
    CUI_OBJECT_BLOCK(
                     [value isKindOfClass:UIVisualEffectView.class]?
                     [((UIVisualEffectView *)value).contentView addSubview:self]:
                     [value addSubview:self];
                     );
}

- (CUIChainableUIViewObjectBlock)addChild {
    CUI_OBJECT_BLOCK([self cui_addChild:value]);
}

- (instancetype)clip {
    self.clipsToBounds = YES;
    return self;
}

- (instancetype)touchEnabled {
    self.userInteractionEnabled = YES;
    return self;
}

- (instancetype)touchDisabled {
    self.userInteractionEnabled = NO;
    return self;
}

- (instancetype)stateDisabled {
    if ([self respondsToSelector:@selector(setEnabled:)]) {
        [((id)self) setEnabled:NO];
    }
    return self;
}

- (instancetype)invisible {
    self.hidden = YES;
    return self;
}

- (void (^)(void))End {
    return ^{};
}

@end


@implementation UIView (CUIChainable_Frame)


#define CUINull             NSIntegerMax
#define CUI_SAFE_ASSIGN(a, b)   if (b != CUINull && b!= NSIntegerMin) a = b

- (CUIChainableUIViewRectBlock)xywh {
    return ^(CUIRect rect) {
        CGRect frame = rect.value;
        CGRect newFrame = self.frame;
        
        //setting x
        if (frame.size.width != NSIntegerMin) {
            CUI_SAFE_ASSIGN(newFrame.origin.x, frame.origin.x);
            
        //setting maxX
        } else  if (frame.origin.x != CUINull) {
            newFrame.origin.x = frame.origin.x - newFrame.size.width;
        }
        
        //setting y
        if (frame.size.height != NSIntegerMin) {
            CUI_SAFE_ASSIGN(newFrame.origin.y, frame.origin.y);
            
        //setting maxY
        } else if (frame.origin.y != CUINull) {
            newFrame.origin.y = frame.origin.y - newFrame.size.height;
        }
        
        CUI_SAFE_ASSIGN(newFrame.size.width, frame.size.width);
        CUI_SAFE_ASSIGN(newFrame.size.height, frame.size.height);
        
        self.frame = newFrame;
        return self;
    };
}

- (CUIChainableUIViewPointBlock)cxy {
    return ^(CUIPoint point) {
        CGPoint center = point.value;
        CGPoint newCenter = self.center;
        
        CUI_SAFE_ASSIGN(newCenter.x, center.x);
        CUI_SAFE_ASSIGN(newCenter.y, center.y);
        
        self.center = newCenter;
        return self;
    };
}

- (instancetype)fitWidth {
    return self.w([self sizeThatFits:CGSizeMake(MAXFLOAT, self.h)].width);
}

- (instancetype)fitHeight {
    return self.h([self sizeThatFits:CGSizeMake(self.w, MAXFLOAT)].height);
}

- (instancetype)fitSize {
    [self sizeToFit];
    return self;
}

- (instancetype)flexibleLeft {
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
    return self;
}

- (instancetype)flexibleRight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
    return self;
}

- (instancetype)flexibleTop {
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
    return self;
}

- (instancetype)flexibleBottom {
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
    return self;
}

- (instancetype)flexibleLR {
    return self.flexibleLeft.flexibleRight;
}

- (instancetype)flexibleTB {
    return self.flexibleTop.flexibleBottom;
}

- (instancetype)flexibleLRTB {
    return self.flexibleLeft.self.flexibleRight.self.flexibleTop.self.flexibleBottom;
}

- (instancetype)flexibleWidth {
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
    return self;
}

- (instancetype)flexibleHeight {
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
    return self;
}

- (instancetype)flexibleWH {
    return self.flexibleWidth.self.flexibleHeight;
}

@end




@implementation UIView (CUIChainable_Autolayout)

- (CUIChainableUIViewFloatBlock)horHugging {
    CUI_FLOAT_BLOCK([self setContentHuggingPriority:value forAxis:UILayoutConstraintAxisHorizontal]);
}

- (CUIChainableUIViewFloatBlock)verHugging {
    CUI_FLOAT_BLOCK([self setContentHuggingPriority:value forAxis:UILayoutConstraintAxisVertical]);
}

- (CUIChainableUIViewFloatBlock)horResistance {
    CUI_FLOAT_BLOCK([self setContentCompressionResistancePriority:value forAxis:UILayoutConstraintAxisHorizontal]);
}

- (CUIChainableUIViewFloatBlock)verResistance {
    CUI_FLOAT_BLOCK([self setContentCompressionResistancePriority:value forAxis:UILayoutConstraintAxisVertical]);
}

- (CUIChainableUIViewFloatBlock)fixWidth {
    CUI_FLOAT_BLOCK(Constraint(self).width.constants(value).priority(950).update());
}

- (CUIChainableUIViewFloatBlock)fixHeight {
    CUI_FLOAT_BLOCK(Constraint(self).height.constants(value).priority(950).update());
}

- (CUIChainableUIViewSizeBlock)fixWH {
    CUI_SIZE_BLOCK(Constraint(self).size.constants(value.value.width, value.value.height).priority(950).update());
}

- (CUIChainableUIViewEmbedBlock)embedIn {
    return ^(UIView *superview, UIEdgeInsets insets) {
        if ([superview isKindOfClass:UIVisualEffectView.class]) {
            superview = ((UIVisualEffectView *)superview).contentView;
        }
        
        [superview addSubview:self];
        
        if (insets.top != CUINull) {
            Constraint(self).top.constants(insets.top).priority(950).update();
        }
        
        if (insets.left != CUINull) {
            Constraint(self).left.constants(insets.left).priority(950).update();
        }
        
        if (insets.bottom != CUINull) {
            Constraint(self).bottom.constants(-insets.bottom).priority(950).update();
        }
        
        if (insets.right != CUINull) {
            Constraint(self).right.constants(-insets.right).priority(950).update();
        }
        
        return self;
    };
}

- (instancetype)lowHugging {
    return self.horHugging(100).verHugging(100);
}

- (instancetype)highHugging {
    return self.horHugging(900).verHugging(900);
}

- (instancetype)lowResistance {
    return self.horResistance(100).verResistance(100);
}

- (instancetype)highResistance {
    return self.horResistance(900).verResistance(900);
}


#define SYNTHESIZE_CONSTRIANTS_PROP(x, y) \
- (CUIChainableUIViewObjectBlock)x {\
    CUI_OBJECT_BLOCK(\
                     if (CUI_IS_BLOCK(value)) {\
                         CUIConstraintMaker *make = [[CUIConstraintMaker alloc] initWithFirstItem:self];\
                         ((CUIObjectBlock)value)(make);\
                         [make y:nil];\
                     }\
    );\
}

//- (CUIChainableUIViewObjectBlock)makeCons {
//    CUI_OBJECT_BLOCK(
//                     if (CUI_IS_BLOCK(value)) {
//        NSLog(@"11111");
//                         CUIConstraintMaker *make = [[CUIConstraintMaker alloc] initWithFirstItem:self];
//                         ((CUIObjectBlock)value)(make);
//                         [make makeConstraints:nil];
//                     }
//    );
//}
//

SYNTHESIZE_CONSTRIANTS_PROP(makeCons, makeConstraints);
SYNTHESIZE_CONSTRIANTS_PROP(remakeCons, remakeConstraints);
SYNTHESIZE_CONSTRIANTS_PROP(updateCons, updateConstraints);

@end


