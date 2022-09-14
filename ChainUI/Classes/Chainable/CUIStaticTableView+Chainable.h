//
//  CUIStaticTableView+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIStaticTableView.h"
#import "CUIDefs.h"

#define Row                 [CUIStaticRow new]
#define Section(...)        [CUIStaticSection sectionWithRows:@[__VA_ARGS__]]

#define PlainTV(...)        [CUIStaticTableView plainStyleWithSections:@[__VA_ARGS__]]
#define GroupTV(...)        [CUIStaticTableView groupedStyleWithSections:@[__VA_ARGS__]]

#define detailFnt(x)        detailFnt(CUI_CONVERT_VALUE_TO_STRING(x))



NS_ASSUME_NONNULL_BEGIN

@interface CUIStaticTableView (Chainable)

/**
 * default textLabel.font
 */
CUI_STATIC_PROP(Object)     fnt;

/**
 * default textLabel.color
 */
CUI_STATIC_PROP(Object)     color;

/**
 * default detailTextLabel.font
 */
CUI_STATIC_PROP(Object)     detailFnt;

/**
 * default detailTextLabel.color
 */
CUI_STATIC_PROP(Object)     detailColor;

/**
 * default cell height
 */
CUI_STATIC_PROP(Float)      cellHeight;

/**
 * default separator left inset
 */
CUI_STATIC_PROP(Float)      separatorLeftInset;

/**
 * section gap for GroupedTableView
 * Will change section header and section footer internally.
 */
CUI_STATIC_PROP(Float)      groupGap;

/**
 * TableView header
 * Argument can be:
   1) UIView
   2) NSNumber for empty header with specific height.
 * Usages: .header(headerView), .header(@50)
 */
CUI_STATIC_PROP(Object)     header;

/**
 * TableView footer
 * Argument can be:
   1) UIView
   2) NSNumber for empty footer with specific height.
 * Usages: .footer(headerView), .footer(@50)
 */
CUI_STATIC_PROP(Object)     footer;

/**
 * Configure row before display on screen.
 * Usages:
    .configRow(^(CUIStaticRow *row, NSIndexPath *indexPath) {
        row.checked(indexPath.row == 3);
    });
 */
CUI_STATIC_PROP(Block)      configRow;

/**
 * Configure cell before display on screen.
 * Usages:
    .configCell(^(UITableViewCell *cell, NSIndexPath *indexPath) {
        cell.textLabel.str(indexPath);
    });
 */
CUI_STATIC_PROP(Block)      configCell;

/**
 * tintColor
 */
CUI_STATIC_PROP(Object)     tint;

/**
 * Apply default sytles
 */
CUI_STATIC_PROP(Object)     styles;

@end



@interface CUIStaticSection (CUIChainable)


CUI_SECTION_PROP(Object)    title;
CUI_SECTION_PROP(Object)    titleFont;
CUI_SECTION_PROP(Object)    titleColor;
/**
 * Section header
 * Argument can be:
   1) UIView
   2) NSNumber for empty header with specific height.
 * Usages: .header(headerView), .header(@50)
 */
CUI_SECTION_PROP(Object)    header;

/**
 * Section footer
 * Argument can be:
   1) UIView
   2) NSNumber for empty footer with specific height.
 * Usages: .footer(footerView), .footer(@0)
 */
CUI_SECTION_PROP(Object)    footer;

/**
 * Enable single check for rows in section.
 * You can get the checked indexPath with -checkedIndexPaths method inside CUIStaticTableView class.
 */
- (instancetype)singleCheck;

/**
 * Enable multiply check for rows in section.
 * You can get the checked indexPaths with -checkedIndexPaths method inside CUIStaticTableView class.
 */
- (instancetype)multiCheck;

@end



@interface CUIStaticRow (CUIChainable)

/**
 * imageView.image
 */
CUI_ROW_PROP(Object)        img;

/**
 * textLabel.text
 */
CUI_ROW_PROP(Object)        str;

/**
 * textLabel.font
 */
CUI_ROW_PROP(Object)        fnt;

/**
 * textLabel.color
 */
CUI_ROW_PROP(Object)        color;

/**
 * detailTextLabel.text
 */
CUI_ROW_PROP(Object)        detailStr;

/**
 * detailTextLabel.font
 */
CUI_ROW_PROP(Object)        detailFnt;

/**
 * detailTextLabel.color
 */
CUI_ROW_PROP(Object)        detailColor;

/**
 * accessoryView
 * Usages: .accessoryView([UISwitch new])
 */
CUI_ROW_PROP(Object)        accessory;

/**
 * Whether or not to check the cell.
 * Use UITableViewCellAccessoryCheckmark internally.
 * Usages: .check(YES), .check(NO)
 */
CUI_ROW_PROP(Bool)          check;

/**
 * Cell height
 * Usages: .cellHeight(60)
 */
CUI_ROW_PROP(Float)         cellHeight;

/**
 * Separator left inset
 * Usages: .separatorLeftInset(10)
 */
CUI_ROW_PROP(Float)         separatorLeftInset;

/**
 * Custom cell
 * Argument can be:
   1) xib file name
   2) cell class name
   3) UITableViewCell object
   4) custom block for set up UITableViewCell
 
 * Usages:
    .custom(@"NewsCell")
    .custom(^(UITableViewCell *cell) {
        HStack(Label.str(@"hello")).embedIn(cell);
    });
 */
CUI_ROW_PROP(Object)        custom;

/**
 * Selection callback
 * Only if you set a callback block, can the cell be selected.
 * Usages: .onClick(^{})
 */
CUI_ROW_PROP(Callback)      onClick;

/**
 * Apply style to UITableViewCell
 */
CUI_ROW_PROP(Object)        styles;

//UITableViewAutomaticDimension
- (instancetype)cellHeightAuto;

//UITableViewCellStyleSubtitle
- (instancetype)subtitleStyle;

//UITableViewCellStyleValue2
- (instancetype)value2Style;

//UITableViewCellAccessoryDisclosureIndicator
- (instancetype)disclosure;
@end

NS_ASSUME_NONNULL_END
