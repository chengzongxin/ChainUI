//
//  CUIStaticTableView+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIStaticTableView+Chainable.h"
#import "UIColor+Chainable.h"
#import "UIFont+Chainable.h"
#import "UIView+Chainable.h"
#import "UIImage+Chainable.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"



@implementation CUIStaticTableView (Chainable)

- (CUIChainableCUIStaticTableViewObjectBlock)fnt {
    CUI_OBJECT_BLOCK([self setValue:Fnt(value) forKey:@"textFont"]);
}

- (CUIChainableCUIStaticTableViewObjectBlock)color {
    CUI_OBJECT_BLOCK([self setValue:Color(value) forKey:@"textColor"]);
}

- (CUIChainableCUIStaticTableViewObjectBlock)detailFnt {
    CUI_OBJECT_BLOCK([self setValue:Fnt(value) forKey:@"detailTextFont"]);
}

- (CUIChainableCUIStaticTableViewObjectBlock)detailColor {
    CUI_OBJECT_BLOCK([self setValue:Color(value) forKey:@"detailTextColor"]);
}

- (CUIChainableCUIStaticTableViewFloatBlock)cellHeight {
    CUI_FLOAT_BLOCK([self setValue:@(value) forKey:@"cellHeightNumber"]);
}

- (CUIChainableCUIStaticTableViewFloatBlock)separatorLeftInset {
    CUI_FLOAT_BLOCK(
                    UIEdgeInsets insets = UIEdgeInsetsMake(0, value, 0, 0);
                    [self setValue:[NSValue valueWithUIEdgeInsets:insets] forKey:@"lineInsets"];
                    );
}

- (CUIChainableCUIStaticTableViewFloatBlock)groupGap {
    CUI_FLOAT_BLOCK(
                    if (self.style == UITableViewStyleGrouped) {
                        [self setValue:@(value) forKey:@"groupSpacingNumber"];
                    }
                    );
}

- (CUIChainableCUIStaticTableViewBlockBlock)configRow {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"configRowBlock"]);
}

- (CUIChainableCUIStaticTableViewBlockBlock)configCell {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"configCellBlock"]);
}

- (CUIChainableCUIStaticTableViewObjectBlock)styles {
    CUI_OBJECT_BLOCK([CUIUtils applyStyleObject:value toItem:self];);
}

- (CUIChainableCUIStaticTableViewObjectBlock)tint {
    CUI_OBJECT_BLOCK(self.tintColor = Color(value));
}

- (CUIChainableCUIStaticTableViewObjectBlock)header {
    CUI_OBJECT_BLOCK(
                     if ([value isKindOfClass:UIView.class]) {
                         self.tableHeaderView = value;
                     } else if ([value isKindOfClass:NSNumber.class]) {
                         self.tableHeaderView = View.h([value floatValue]).bgColor(@"clear");
                     }
                     );
}

- (CUIChainableCUIStaticTableViewObjectBlock)footer {
    CUI_OBJECT_BLOCK(
                     if ([value isKindOfClass:UIView.class]) {
                         self.tableFooterView = value;
                     } else if ([value isKindOfClass:NSNumber.class]) {
                         self.tableFooterView = View.h([value floatValue]).bgColor(@"clear");
                     }
                     );
}

@end



@implementation CUIStaticSection (CUIChainable)

- (CUIChainableCUIStaticSectionObjectBlock)title{
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"titleObject"]);
}

- (CUIChainableCUIStaticSectionObjectBlock)titleFont{
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"titleObjectFont"]);
}

- (CUIChainableCUIStaticSectionObjectBlock)titleColor{
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"titleObjectColor"]);
}

- (CUIChainableCUIStaticSectionObjectBlock)header {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"headerObject"]);
}

- (CUIChainableCUIStaticSectionObjectBlock)footer {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"footerObject"]);
}

- (instancetype)singleCheck {
    [self setValue:@(CUIStaticSectionCheckStyleSingle) forKey:@"checkStyle"];
    return self;
}

- (instancetype)multiCheck {
    [self setValue:@(CUIStaticSectionCheckStyleMultiply) forKey:@"checkStyle"];
    return self;
}

@end



@implementation CUIStaticRow (CUIChainable)

- (CUIChainableCUIStaticRowObjectBlock)img {
    CUI_OBJECT_BLOCK([self setValue:Img(value) forKey:@"image"]);
}

- (CUIChainableCUIStaticRowObjectBlock)str {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"text"]);
}

- (CUIChainableCUIStaticRowObjectBlock)fnt {
    CUI_OBJECT_BLOCK([self setValue:Fnt(value) forKey:@"textFont"]);
}

- (CUIChainableCUIStaticRowObjectBlock)color {
    CUI_OBJECT_BLOCK([self setValue:Color(value) forKey:@"textColor"]);
}

- (CUIChainableCUIStaticRowObjectBlock)detailStr {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"detailText"]);
}

- (CUIChainableCUIStaticRowObjectBlock)detailFnt {
    CUI_OBJECT_BLOCK([self setValue:Fnt(value) forKey:@"detailTextFont"]);
}

- (CUIChainableCUIStaticRowObjectBlock)detailColor {
    CUI_OBJECT_BLOCK([self setValue:Color(value) forKey:@"detailTextColor"]);
}

- (CUIChainableCUIStaticRowFloatBlock)cellHeight {
    CUI_FLOAT_BLOCK([self setValue:@(value) forKey:@"cellHeightNumber"]);
}

- (CUIChainableCUIStaticRowFloatBlock)separatorLeftInset {
    CUI_FLOAT_BLOCK(
                    UIEdgeInsets insets = UIEdgeInsetsMake(0, value, 0, 0);
                    [self setValue:[NSValue valueWithUIEdgeInsets:insets] forKey:@"lineInsets"];
    );
}

- (CUIChainableCUIStaticRowCallbackBlock)onClick {
    CUI_CALLBACK_BLOCK(
                       if (CUI_IS_BLOCK(object)) {
                           [self setValue:object forKey:@"selectionBlock"];
                           
                       } else {
                           id block = ^{
                               SEL action = NSSelectorFromString(object);
                               [weakTarget performSelector:action withObject:nil];
                           };
                           
                           [self setValue:block forKey:@"selectionBlock"];
                       }
                       );
}

- (CUIChainableCUIStaticRowObjectBlock)accessory {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"accessoryView"]);
}

- (CUIChainableCUIStaticRowBoolBlock)check {
    CUI_INT_BLOCK(
                  id n = @(value? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone);
                  [self setValue:n forKey:@"accessoryType"];
                  );
}

- (CUIChainableCUIStaticRowObjectBlock)custom {
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"cellObject"]);
}

- (CUIChainableCUIStaticRowObjectBlock)styles {
    CUI_OBJECT_BLOCK([CUIUtils applyStyleObject:value toItem:self];);
}

- (instancetype)cellHeightAuto {
    self.cellHeight(UITableViewAutomaticDimension);
    return self;
}

- (instancetype)subtitleStyle {
    [self setValue:@(UITableViewCellStyleSubtitle) forKey:@"style"];
    return self;
}

- (instancetype)value2Style {
    [self setValue:@(UITableViewCellStyleValue2) forKey:@"style"];
    return self;
}

- (instancetype)disclosure {
    [self setValue:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
    return self;
}

@end
