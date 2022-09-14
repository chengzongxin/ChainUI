//
//  NSAttributedString+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "NSAttributedString+Chainable.h"
#import "UIFont+Chainable.h"
#import "UIColor+Chainable.h"

@implementation NSAttributedString (Chainable)

@end

@implementation NSMutableAttributedString (Chainable)

- (CUIChainableNSMutableAttributedStringObjectBlock)fnt {
    CUI_OBJECT_BLOCK([self cui_applyAttribute:NSFontAttributeName withValue:Fnt(value)]);
}

- (CUIChainableNSMutableAttributedStringObjectBlock)color {
    CUI_OBJECT_BLOCK([self cui_applyAttribute:NSForegroundColorAttributeName withValue:Color(value)]);
}

- (CUIChainableNSMutableAttributedStringObjectBlock)bgColor {
    CUI_OBJECT_BLOCK([self cui_applyAttribute:NSBackgroundColorAttributeName withValue:Color(value)]);
}

- (CUIChainableNSMutableAttributedStringObjectBlock)systemLink {
    CUI_OBJECT_BLOCK([self cui_applyAttribute:NSLinkAttributeName withValue:value]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)kern {
    CUI_FLOAT_BLOCK([self cui_applyAttribute:NSKernAttributeName withValue:@(value)]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)stroke {
    CUI_FLOAT_BLOCK([self cui_applyAttribute:NSStrokeWidthAttributeName withValue:@(value)]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)oblique {
    CUI_FLOAT_BLOCK([self cui_applyAttribute:NSObliquenessAttributeName withValue:@(value)]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)expansion {
    CUI_FLOAT_BLOCK([self cui_applyAttribute:NSExpansionAttributeName withValue:@(value)]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)baselineOffset {
    CUI_FLOAT_BLOCK([self cui_applyAttribute:NSBaselineOffsetAttributeName withValue:@(value)]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)indent {
    CUI_FLOAT_BLOCK([self cui_setParagraphStyleValue:@(value) forKey:@"firstLineHeadIndent"]);
}

- (CUIChainableNSMutableAttributedStringFloatBlock)lineGap {
    CUI_FLOAT_BLOCK([self cui_setParagraphStyleValue:@(value) forKey:@"lineSpacing"]);
}

- (CUIChainableNSMutableAttributedStringObjectBlock)match {
    CUI_OBJECT_BLOCK(
                     if (!self.cuiIsJustSettingEffectedRanges) {
                         [self.cuiEffectedRanges removeAllIndexes];
                     }
                     
                     NSRegularExpression *exp = nil;
                     if ([value isKindOfClass:NSRegularExpression.class]) {
                         exp = value;
                     } else {
                         exp = [[NSRegularExpression alloc] initWithPattern:value options:0 error:nil];
                     }
                     
                     NSArray *matches = [exp matchesInString:self.string options:0 range:[self.string cui_fullRange]];
                     for (NSTextCheckingResult *result in matches) {
                         [self.cuiEffectedRanges addIndexesInRange:result.range];
                     }
                     
                     self.cuiIsJustSettingEffectedRanges = YES;
                     );
}

- (CUIChainableNSMutableAttributedStringTwoIntBlock)range {
    CUI_TWO_INT_BLOCK(
                      if (!self.cuiIsJustSettingEffectedRanges) {
                          [self.cuiEffectedRanges removeAllIndexes];
                      }
                      
                      if (value1 < 0) {
                          value1 = self.string.length + value1;
                      }
                      [self.cuiEffectedRanges addIndexesInRange:NSMakeRange(value1, value2)];
                      self.cuiIsJustSettingEffectedRanges = YES;
                      );
}

- (CUIChainableNSMutableAttributedStringObjectBlock)styles {
    CUI_OBJECT_BLOCK([CUIUtils applyStyleObject:value toItem:self];);
}

- (instancetype)underline {
    [self cui_applyAttribute:NSUnderlineStyleAttributeName withValue:@(NSUnderlineStyleSingle)];
    return self;
}

- (instancetype)strikeThrough {
    [self cui_applyAttribute:NSStrikethroughStyleAttributeName withValue:@(NSUnderlineStyleSingle)];
    return self;
}

- (instancetype)letterpress {
    [self cui_applyAttribute:NSTextEffectAttributeName withValue:NSTextEffectLetterpressStyle];
    return self;
}

- (instancetype)matchNumber {
    return self.match(@"\\d+(\\.\\d+)?");
}

- (instancetype)matchURL {
    NSDataDetector *urlDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    return self.match(urlDetector);
}

- (instancetype)matchHashTag {
    return self.match(@"(?<!\\w)#([\\w\\_]+)?");
}

- (instancetype)matchNameTag {
    return self.match(@"(?<!\\w)@([\\w\\_]+)?");
}

- (instancetype)linkForLabel {
    [self cui_applyAttribute:CUILinkAttributeName withValue:CUILinkAttributeValue];
    return self;
}

- (instancetype)ifNotExists {
    self.cuiAddAttributeIfNotExists = YES;
    return self;
}

- (instancetype)leftAlignment {
    [self cui_setParagraphStyleValue:@(NSTextAlignmentLeft) forKey:@"alignment"];
    return self;
}

- (instancetype)centerAlignment {
    [self cui_setParagraphStyleValue:@(NSTextAlignmentCenter) forKey:@"alignment"];
    return self;
}

- (instancetype)rightAlignment {
    [self cui_setParagraphStyleValue:@(NSTextAlignmentRight) forKey:@"alignment"];
    return self;
}

- (instancetype)justifiedAlignment {
    [self cui_setParagraphStyleValue:@(NSTextAlignmentJustified) forKey:@"alignment"];
    return self;
}

- (void (^)(void))End {
    return ^{};
}

@end
