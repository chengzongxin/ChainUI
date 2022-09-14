//
//  NSArray+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "NSArray+Chainable.h"
#import "CUIBlockInfo.h"
#import "CUIDefs.h"

@implementation NSArray (Chainable)


- (id)cui_invokeBlock:(CUIBlockInfo *)blockInfo withValue:(id)value atIndex:(NSInteger)index {
    id result = nil;
    
#define INVODE_WITH_RETURN_TYPE(x)  \
    [blockInfo isAcceptingIntAtIndex:0]?\
        ((x (^)(long long, NSInteger, id))blockInfo.block)([value longLongValue], index, self):\
        [blockInfo isAcceptingFloatAtIndex:0]?\
            ((x (^)(double, NSInteger, id))blockInfo.block)([value doubleValue], index, self):\
            ((x (^)(id, NSInteger, id))blockInfo.block)(value, index, self)
    
    if (blockInfo.isReturningInt) {
        result = @(INVODE_WITH_RETURN_TYPE(long long));
    } else if (blockInfo.isReturningFloat) {
        result = @(INVODE_WITH_RETURN_TYPE(double));
    } else {
        result = INVODE_WITH_RETURN_TYPE(id);
    }
    
    return result;
}

- (id)cui_invokeBlock:(CUIBlockInfo *)blockInfo withAccumulator:(id)accumulator value:(id)value atIndex:(NSInteger)index {
    id result = nil;
    
#define INVODE_WITH_RETURN_TYPE2(x)  \
    [blockInfo isAcceptingIntAtIndex:0]?\
    ((x (^)(long long, long long, NSInteger, id))blockInfo.block)([accumulator longLongValue], [value longLongValue], index, self):\
    [blockInfo isAcceptingFloatAtIndex:0]?\
        ((x (^)(double, double, NSInteger, id))blockInfo.block)([accumulator longLongValue], [value doubleValue], index, self):\
        ((x (^)(id, id, NSInteger, id))blockInfo.block)(accumulator, value, index, self)
    
    if (blockInfo.isReturningInt) {
        result = @(INVODE_WITH_RETURN_TYPE2(long long));
    } else if (blockInfo.isReturningFloat) {
        result = @(INVODE_WITH_RETURN_TYPE2(double));
    } else {
        result = INVODE_WITH_RETURN_TYPE2(id);
    }
    
    return result;
}

- (NSArray *)cui_invokeBlockForEachElement:(id)block filterResult:(BOOL)filter {
    if (block) {
        CUIBlockInfo *blockInfo = [[CUIBlockInfo alloc] initWithBlock:block];
        
        if (blockInfo.argumentCount > 0) {
            NSMutableArray *targets = [NSMutableArray arrayWithCapacity:self.count];
            
            for (NSInteger i = 0; i < self.count; ++i) {
                id result = [self cui_invokeBlock:blockInfo withValue:self[i] atIndex:i];
                
                if (!filter) {
                    [targets addObject:result];
                } else if ([result boolValue]) {
                    [targets addObject:self[i]];
                }
            }
            
            return (NSArray *)[targets copy];
        }
    }
    
    return self;
}


- (NSArray *(^)(id))forEach {
    return ^(id object) {
        if ([object isKindOfClass:NSString.class]) {
            [self makeObjectsPerformSelector:NSSelectorFromString(object)];
            
        } else {
            CUIBlockInfo *blockInfo = [[CUIBlockInfo alloc] initWithBlock:object];
            if (blockInfo.argumentCount > 0) {
                for (NSInteger i = 0; i < self.count; ++i) {
                    [self cui_invokeBlock:blockInfo withValue:self[i] atIndex:i];
                }
            }
        }
        
        return self;
    };
}

- (NSArray *(^)(id))map {
    return ^(id block) {
        return [self cui_invokeBlockForEachElement:block filterResult:NO];
    };
}

- (NSArray *(^)(id))filter {
    return ^(id block) {
        return [self cui_invokeBlockForEachElement:block filterResult:YES];
    };
}

- (id (^)(id, ...))reduce {
    return ^(id blockOrInitialValue, ...) {
        id block = nil;
        id initialValue = nil;
    
        if (CUI_IS_BLOCK(blockOrInitialValue)) {
            block = blockOrInitialValue;
        } else {
            initialValue = blockOrInitialValue;
            block = CUI_FIRAT_VA_ARGS(blockOrInitialValue, id);
        }
        
        if (block) {
            CUIBlockInfo *blockInfo = [[CUIBlockInfo alloc] initWithBlock:block];
            
            if (blockInfo.argumentCount > 0) {
                id accumulator = self.firstObject;
                NSInteger beginIndex = 1;
                
                if (initialValue) {
                    accumulator = initialValue;
                    beginIndex = 0;
                }
                
                for (NSInteger i = beginIndex; i < self.count; ++i) {
                    accumulator = [self cui_invokeBlock:blockInfo withAccumulator:accumulator value:self[i] atIndex:i];
                }
                
                return accumulator;
            }
        }
        
        return initialValue;
    };
}
@end
