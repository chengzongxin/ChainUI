//
//  CUIStaticTableView.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CUIStaticSectionCheckStyleNone,
    CUIStaticSectionCheckStyleSingle,
    CUIStaticSectionCheckStyleMultiply,
} CUIStaticSectionCheckStyle;


@interface CUIStaticTableView : UITableView

+ (instancetype)plainStyleWithSections:(NSArray *)sections;
+ (instancetype)groupedStyleWithSections:(NSArray *)sections;

- (NSArray *)checkedIndexPaths;

@end



@interface CUIStaticSection : NSObject

+ (instancetype)sectionWithRows:(NSArray *)rows;

@end



@interface CUIStaticRow : NSObject

@end

NS_ASSUME_NONNULL_END
