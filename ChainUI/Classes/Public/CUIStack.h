//
//  CUIStack.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    CUIStackAlignmentLeading,
    CUIStackAlignmentTop = CUIStackAlignmentLeading,
    CUIStackAlignmentCenter,
    CUIStackAlignmentTrailing,
    CUIStackAlignmentBotttom = CUIStackAlignmentTrailing,
    CUIStackAlignmentBaseline,
    CUIStackAlignmentFirstBaseline,
} CUIStackAlignment;


@interface CUIStack : UIView

@property (nonatomic, assign) UILayoutConstraintAxis axis;
@property (nonatomic, assign) CUIStackAlignment alignment;
@property (nonatomic, assign) CGFloat spacing;

@property (nonatomic, readonly) NSMutableArray *arrangedSubviews;

+ (instancetype)verticalStackWithItems:(NSArray *)items;
+ (instancetype)horizontalStackWithItems:(NSArray *)items;

- (void)addArrangedSubview:(id)view;
- (void)insertArrangedSubview:(id)view atIndex:(NSUInteger)stackIndex;

- (void)removeArrangedSubview:(UIView *)view;
- (void)removeArrangedSubviewAtIndex:(NSInteger)index;

@end


@interface CUIStackSpring : UIView

@end






NS_ASSUME_NONNULL_END
