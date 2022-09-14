//
//  CUIStack+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIStack.h"
#import "CUIDefs.h"

/**
 * Horizontal Stack with items.
 * Each item is stack horizontally, from left to right with optional spacing.
 
 * There are two way to specify fix spacing:
    1) Use NSNumber for individual spacing between two items.
    2) Use .gap for spacing between all subviews.
   If set both, the NSNumber approach take precedence.
 
 * There is also a CUISpring object that will take as mush space if available. Just like a spring.
 
 * By embed CUIStack into another stack, you are able to create a much more complicated UI.
 
 * Usages:
    HStack(view1, @5, view2, @10, view3)
    Hstack(view1, view2, view3).gap(5)
 */
#define HorStack(...)       [CUIStack horizontalStackWithItems:@[__VA_ARGS__]]

/**
 * Vertical Stack with items.
 * Each item is stack vertically, from top to bottom with optional spacing.
 
 * Usages:
    VStack(view1, @5, view2, @10, view3)
    VStack(view1, view2, view3).gap(5)
 */
#define VerStack(...)       [CUIStack verticalStackWithItems:@[__VA_ARGS__]]

/**
 * Unlike gap create a fix spacing, CUISpring carete an spacing that can shrink or expand.
 * All the CUISprings in the same Stack will take up the same spaces.
 * Usages: HStack(view1, CUISpring, view2, CUISpring, view3).embedIn(self.view);
 */
#define CUISpring           [CUIStackSpring new]

NS_ASSUME_NONNULL_BEGIN

@interface CUIStack (Chainable)

/**
 * Item spacing
 * Usages: .gap(10)
 */
CUI_STACK_PROP(Float)       gap;

/**
 * Add Subviews.
 * It can take one or more arguments.
 * Usages: addChild(subview), addChild(subview1, subview2, subview3, ...)
 */
CUI_STACK_PROP(Object)      addChild;

/**
 * Align items.
 
 * For HStack, the valid alignments are:
    .topAlignment
    .bottomAlignment
    .centerAlignment (default)
    .baselineAlignment
    .firstBaselineAlignment
 
 * For VStack, the valid alignments are:
    .leftAlignment (default)
    .rightAlignment
    .centerAlignment
 
 * Usages: .bottomAlignment
 */
- (instancetype)topAlignment;
- (instancetype)bottomAlignment;
- (instancetype)leftAlignment;
- (instancetype)rightAlignment;
- (instancetype)centerAlignment;
- (instancetype)baselineAlignment;
- (instancetype)firstBaselineAlignment;

@end

NS_ASSUME_NONNULL_END
