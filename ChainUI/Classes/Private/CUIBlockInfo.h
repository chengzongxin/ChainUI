//
//  CUIBlockInfo.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CUIBlockInfo : NSObject


@property (nonatomic, readonly) id block;
@property (nonatomic, readonly) NSMethodSignature *signature;

@property (nonatomic, readonly) NSInteger argumentCount;
@property (nonatomic, readonly) const char *returnType;

@property (nonatomic, readonly) BOOL isReturningInt;
@property (nonatomic, readonly) BOOL isReturningFloat;
@property (nonatomic, readonly) BOOL isReturningObject;

- (instancetype)initWithBlock:(id)block;

- (const char *)argumentTypeAtIndex:(NSInteger)index;

- (BOOL)isAcceptingIntAtIndex:(NSInteger)index;
- (BOOL)isAcceptingFloatAtIndex:(NSInteger)index;
- (BOOL)isAcceptingObjectAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
