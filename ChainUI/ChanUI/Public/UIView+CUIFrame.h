//
//  UIView+CUIFrame.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <UIKit/UIKit.h>

#define XY(x, y)                CGPointMake(x, y)
#define WH(w, h)                CGSizeMake(w, h)

/**
 * Usages:
    XYWH(10, 10, 50, 50)
    XYWH(XY(10, 10), WH(50, 50))
    XYWH(XY(10, 10), 50, 50)
    XYWH(10, 10, WH(50, 50))
 */
#define XYWH(...)               ((CUIRect){__VA_ARGS__}).value

#define Range(s, l)             NSMakeRange(s, l)

/**
 * Usages:
    Insets(10)                  //{10, 10, 10, 10}
    Insets(10, 20)              //{10, 20, 10, 20}
    Insets(10, 20, 30)          //{10, 20, 30, 20}
    Insets(10, 20, 30, 40)      //{10, 20, 30, 40}
 */
#define Insets(...)             CUI_NORMALIZE_INSETS(__VA_ARGS__)

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CUIFrame)

@property (nonatomic, assign) CGFloat x;        //frame.origin.x
@property (nonatomic, assign) CGFloat y;        //frame.origin.y
@property (nonatomic, assign) CGPoint xy;       //frame.origin

@property (nonatomic, assign) CGFloat w;        //frame.size.width
@property (nonatomic, assign) CGFloat h;        //frame.size.height
@property (nonatomic, assign) CGSize  wh;       //frame.size

@property (nonatomic, assign) CGFloat cx;       //center.x
@property (nonatomic, assign) CGFloat cy;       //center.y

@property (nonatomic, assign) CGFloat maxX;     //right of the view
@property (nonatomic, assign) CGFloat maxY;     //bottom of the view
@property (nonatomic, assign) CGPoint maxXY;    //right-bottom point if the view

@property (nonatomic, readonly) CGPoint midPoint;   //bounds center

@end



#define Screen  [UIScreen mainScreen]

@interface UIScreen (CUIFrame)

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) CGSize  size;

//one pixel width, equals to 1 point / screen scale.
@property (nonatomic, readonly) CGFloat onePixel;

@end

NS_ASSUME_NONNULL_END
