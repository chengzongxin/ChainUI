//
//  UIView+ChainUI.m
//  Demo
//
//  Created by Joe.cheng on 2021/2/25.
//

#import "UIView+ChainUI.h"
#import "CUIPrivates.h"

#define CUI_SAFE_ASSIGN(a, b)   if (b != CUINull && b!= NSIntegerMin) a = b
#define CUINull             NSIntegerMax

@implementation UIView (ChainUI)

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
    CUI_INSETS_BLOCK(self.nerTouchInsets = value);
}

- (CUIChainableUIViewCallbackBlock)onClick {
    CUI_CALLBACK_BLOCK(
                        if (CUI_IS_BLOCK(object)) {
                            SEL action = @selector(ner_view_onClickHandler);
                            objc_setAssociatedObject(self, action, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                            [self ner_view_addClickHandler:self action:action];
                        } else {
                            SEL action = NSSelectorFromString(object);
                            [self ner_view_addClickHandler:target action:action];
                        }
    );
}

- (void)ner_view_addClickHandler:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        id reg = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:reg];
    }
}

- (void)ner_view_onClickHandler {
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

//- (CUIChainableUIViewObjectBlock)addChild {
//    CUI_OBJECT_BLOCK([self ner_addChild:value]);
//}

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



