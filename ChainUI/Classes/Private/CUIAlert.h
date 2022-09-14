//
//  CUIAlertMaker.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CUIAlert : NSObject
- (__nullable instancetype)initWithStyle:(UIAlertControllerStyle)style;

- (void)addActionWithStyle:(UIAlertActionStyle)style
                     title:(__nullable id)titleObject
                   handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;

- (UIAlertController * _Nonnull )presentInTopViewController;
@end

NS_ASSUME_NONNULL_END
