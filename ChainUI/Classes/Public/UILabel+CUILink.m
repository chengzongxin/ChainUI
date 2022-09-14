//
//  UILabel+CUILink.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIkit/UIGestureRecognizerSubclass.h>
#import "UILabel+CUILink.h"
#import "CUIDefs.h"
#import "CUIPrivates.h"

@interface CUILinkInfo : NSObject

@property (nonatomic, copy)     NSString *text;
@property (nonatomic, assign)   NSRange range;
@property (nonatomic, strong)   NSArray *boundingRects;

@end

@implementation CUILinkInfo

- (BOOL)containsPoint:(CGPoint)point {
    for (NSValue *rectValue in self.boundingRects) {
        if (CGRectContainsPoint([rectValue CGRectValue], point)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)shouldCancelTouchAtPoint:(CGPoint)point {
    BOOL isNearby = NO;
    
    for (NSValue *rectValue in self.boundingRects) {
        if (CGRectContainsPoint(CGRectInset([rectValue CGRectValue], -50, -50), point)) {
            isNearby = YES;
            break;
        }
    }
    
    return !isNearby;
}

@end


@interface CUILinkGestureRegcognizer : UIGestureRecognizer <UIGestureRecognizerDelegate>
@end

@implementation CUILinkGestureRegcognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateBegan;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateChanged;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateEnded;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateCancelled;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer {
    return NO;
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer {
    return NO;
}

@end



@interface UILabel (CUILinkPrivate)

@property (nonatomic, assign) CGPoint cuiTouchBeginPoint;
@property (nonatomic, strong) CUILinkInfo *cuiSelectedLinkInfo;
@property (nonatomic, strong) NSMutableArray *cuiSelectedLayers;

@end


@implementation UILabel (CUILink)

CUI_SYNTHESIZE_FLOAT(cuiLineGap, setCuiLineGap, [self cui_updateAttributedString]);

CUI_SYNTHESIZE(cuiLinkSelectedColor, setCuiLinkSelectedColor);
CUI_SYNTHESIZE(cuiSelectedLinkInfo, setCuiSelectedLinkInfo);
CUI_SYNTHESIZE(cuiSelectedLayers, setCuiSelectedLayers);

CUI_SYNTHESIZE_FLOAT(cuiLinkSelectedBorderRadius, setCuiLinkSelectedBorderRadius);
CUI_SYNTHESIZE_STRUCT(cuiTouchBeginPoint, setCuiTouchBeginPoint, CGPoint);
CUI_SYNTHESIZE_BLOCK(cuiLinkHandler, setCuiLinkHandler, CUILinkHandler);

static char *cuiPrivateTextStorageKey;
static UIColor *cuiPrivateDefaultLinkSelectedBackgroundColor = nil;
static CGFloat cuiPrivateDefaultLinkSelectedBorderRadius = 0;


+ (void)setDefaultLinkSelectedBackgroundColor:(UIColor *)color borderRadius:(CGFloat)borderRadius {
    cuiPrivateDefaultLinkSelectedBackgroundColor = color;
    cuiPrivateDefaultLinkSelectedBorderRadius = borderRadius;
}

+ (void)load {
    [self cui_swizzleMethod:@selector(setText:) withMethod:@selector(cui_setText:)];
    [self cui_swizzleMethod:@selector(setUserInteractionEnabled:) withMethod:@selector(cui_setUserInteractionEnabled:)];
    [self setDefaultLinkSelectedBackgroundColor:[UIColor darkGrayColor] borderRadius:4];
}

- (void)cui_updateAttributedString {
    if (self.attributedText.string.length) {
        NSMutableAttributedString *att = [self.attributedText mutableCopy];
        [att cui_setParagraphStyleValue:@(self.cuiLineGap) forKey:@"lineSpacing"];
        self.attributedText = att;
    }
}

- (void)cui_setText:(NSString *)text {
    [self cui_setText:text];
    
    if (self.cuiLineGap > 0) {
        [self cui_updateAttributedString];
    }
}

- (void)cui_setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    [self cui_setUserInteractionEnabled:userInteractionEnabled];
    
    if (userInteractionEnabled && ![self cui_containLinkGesture] && self.cuiLinkHandler) {
        id reg = [[CUILinkGestureRegcognizer alloc] initWithTarget:self action:@selector(cui_handleLinkGesture:)];
        [self addGestureRecognizer:reg];
    }
}

- (NSLayoutManager *)cuiLayoutManager {
    NSLayoutManager *layoutManager = objc_getAssociatedObject(self, _cmd);
    
    if (!layoutManager) {
        layoutManager = [[NSLayoutManager alloc] init];
        
        NSTextStorage *textStorage = [[NSTextStorage alloc] init];
        [textStorage addLayoutManager:layoutManager];
        layoutManager.textStorage = textStorage;
        
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
        textContainer.lineFragmentPadding = 0;
        textContainer.layoutManager = layoutManager;
        [layoutManager addTextContainer:textContainer];
        
        objc_setAssociatedObject(self, _cmd, layoutManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, cuiPrivateTextStorageKey, textStorage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [att cui_addAttributeIfNotExist:NSFontAttributeName value:self.font range:[att.string cui_fullRange]];
    [att cui_setParagraphStyleValue:@(self.textAlignment) forKey:@"alignment" range:NSMakeRange(0, att.string.length)];
    
    if (self.numberOfLines != 1 && self.lineBreakMode != NSLineBreakByCharWrapping && self.lineBreakMode != NSLineBreakByWordWrapping) {
        [att cui_setParagraphStyleValue:@(NSLineBreakByWordWrapping) forKey:@"lineBreakMode" range:NSMakeRange(0, att.string.length)];
    }
    
    [layoutManager.textStorage setAttributedString:att];
    NSTextContainer *textContainer = layoutManager.textContainers.firstObject;
    
    textContainer.maximumNumberOfLines = self.numberOfLines;
    textContainer.lineBreakMode = self.lineBreakMode;
    textContainer.size = self.bounds.size;
    return layoutManager;
}

- (void)cui_addHighlightedLayersForLinkInfo:(CUILinkInfo *)info {
    if (!self.cuiSelectedLayers) {
        self.cuiSelectedLayers = [NSMutableArray array];
    }
    
    for (NSValue *rectValue in info.boundingRects) {
        CGRect rect = [rectValue CGRectValue];
        
        if (rect.size.width > 0 && rect.size.height > 0) {
            [self cui_addHighlightedLayerWithFrame:rect];
        }
    }
}

- (void)cui_addHighlightedLayerWithFrame:(CGRect)rect {
    CALayer *layer = [CALayer new];
    layer.frame = rect;
    
    UIColor *color = self.cuiLinkSelectedColor?: cuiPrivateDefaultLinkSelectedBackgroundColor;
    CGFloat borderRadius = cuiPrivateDefaultLinkSelectedBorderRadius;
    
    if (objc_getAssociatedObject(self, @selector(cuiLinkSelectedBorderRadius))) {
        borderRadius = self.cuiLinkSelectedBorderRadius;
    }
    
    if (CGColorGetAlpha(color.CGColor) == 1) {
        color = [color colorWithAlphaComponent:0.4];
    }
    
    [self.layer addSublayer:layer];
        
    layer.cornerRadius = borderRadius;
    layer.backgroundColor = color.CGColor;
    [self.cuiSelectedLayers addObject:layer];
}

- (void)removeHighlightedViews {
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(cui_addHighlightedLayersForLinkInfo:)
                                               object:self.cuiSelectedLinkInfo];
    
    for (CALayer *layer in self.cuiSelectedLayers) {
        [layer removeFromSuperlayer];
    }
    
    [self.cuiSelectedLayers removeAllObjects];
    self.cuiSelectedLayers = nil;
    self.cuiSelectedLinkInfo = nil;
}


- (NSArray *)boundingRectsForTextInRange:(NSRange)range yOffset:(CGFloat)yOffset {
    NSLayoutManager *layoutManager = self.cuiLayoutManager;
    NSTextContainer *textContainer = layoutManager.textContainers.firstObject;
    CGRect textRect = [layoutManager usedRectForTextContainer:textContainer];
    
    NSMutableArray *boundingRects = [NSMutableArray array];
    NSRange glyphRange = [layoutManager glyphRangeForCharacterRange:range actualCharacterRange:NULL];
    
    [layoutManager enumerateEnclosingRectsForGlyphRange:glyphRange
                               withinSelectedGlyphRange:NSMakeRange(NSNotFound, 0)
                                        inTextContainer:textContainer
                                             usingBlock:^(CGRect rect, BOOL * _Nonnull stop) {
                                                 
                                                 CGRect lineRect = [layoutManager lineFragmentUsedRectForGlyphAtIndex:range.location
                                                                                                       effectiveRange:NULL];
                                                 
                                                 NSParagraphStyle *ps = [layoutManager.textStorage attribute:NSParagraphStyleAttributeName
                                                                                                     atIndex:range.location
                                                                                       longestEffectiveRange:NULL
                                                                                                     inRange:range];
                                                 
                                                 if (ps && ps.lineSpacing > 0 && ceilf(CGRectGetMaxY(rect)) != ceilf(CGRectGetMaxY(textRect))) {
                                                     rect.size.height = ceilf(rect.size.height - ps.lineSpacing);
                                                 }
                                                 
                                                 if (CGRectGetMaxX(rect) > CGRectGetMaxX(lineRect)) {
                                                     rect.size.width = CGRectGetMaxX(lineRect) - rect.origin.x;
                                                 }
                                                 
                                                 rect.origin.y += yOffset;
                                                 [boundingRects addObject:[NSValue valueWithCGRect:rect]];
                                             }];
    
    return boundingRects;
}

- (CGFloat)calculateTextYOffset {
    NSLayoutManager *layoutManager = self.cuiLayoutManager;
    NSTextContainer *textContainer = layoutManager.textContainers.firstObject;
    
    NSRange textRange = [layoutManager glyphRangeForTextContainer:textContainer];
    CGRect textRect = [layoutManager boundingRectForGlyphRange:textRange inTextContainer:textContainer];
    
    if (self.bounds.size.height > textRect.size.height) {
        return (self.bounds.size.height - textRect.size.height) / 2;
    } else {
        return 0;
    }
}


- (BOOL)cui_containLinkGesture {
    for (id reg in self.gestureRecognizers) {
        if ([reg isKindOfClass:[CUILinkGestureRegcognizer class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)cui_handleLinkGesture:(UIPanGestureRecognizer *)reg {
    if (reg.state == UIGestureRecognizerStateBegan) {
        [self cui_handleTouchBegin:reg];
        
    } else if (reg.state == UIGestureRecognizerStateChanged) {
        if (!self.cuiSelectedLinkInfo) return;
        
        CGPoint point = [reg locationInView:self];
        if ([self.cuiSelectedLinkInfo shouldCancelTouchAtPoint:point]) {
            [self removeHighlightedViews];
        }
    } else if (reg.state == UIGestureRecognizerStateEnded || reg.state == UIGestureRecognizerStateCancelled) {
        if (self.cuiSelectedLinkInfo) {
            CUILinkHandler handler = self.cuiLinkHandler;
            if (handler) handler(self.cuiSelectedLinkInfo.text, self.cuiSelectedLinkInfo.range);
            [self removeHighlightedViews];
        }
    }
}

- (void)cui_handleTouchBegin:(UIGestureRecognizer *)reg {
    self.cuiTouchBeginPoint = [reg locationInView:self];
    
    __block CGFloat textYOffset = -1;
    
    NSMutableArray *linkInfos = [NSMutableArray array];
    NSRange fullRange = NSMakeRange(0, self.attributedText.string.length);
    
    [self.attributedText enumerateAttribute:CUILinkAttributeName
                                    inRange:fullRange
                                    options:0
                                 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
                                     if (value) {
                                         if (textYOffset == -1) {
                                             textYOffset = [self calculateTextYOffset];
                                         }
                                         
                                         CUILinkInfo *info = [CUILinkInfo new];
                                         info.range = range;
                                         info.text = [self.attributedText.string substringWithRange:range];
                                         info.boundingRects = [self boundingRectsForTextInRange:range yOffset:textYOffset];
                                         [linkInfos addObject:info];
                                     }
                                 }];
    
    for (CUILinkInfo *info in linkInfos) {
        if ([info containsPoint:self.cuiTouchBeginPoint]) {
            self.cuiSelectedLinkInfo = info;
            [self performSelector:@selector(cui_addHighlightedLayersForLinkInfo:) withObject:info afterDelay:0.05];
        }
    }
}
@end
