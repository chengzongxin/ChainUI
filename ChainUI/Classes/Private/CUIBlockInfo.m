//
//  CUIBlockInfo.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "CUIBlockInfo.h"
#import "CUIDefs.h"

//struct CUI_block_descriptor {
//    unsigned long int reserved;
//    unsigned long int size;
//    void (*copy)(void *dst, void *src);
//    void (*dispose)(void *);
//};

struct CUI_block_layout {
    void *isa;
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    
    struct {
        unsigned long int reserved;
        unsigned long int size;
        void (*copy)(void *dst, void *src);
        void (*dispose)(void *);
    } *descriptor;
    
//    struct CUI_block_descriptor *descriptor;
    /* Imported variables. */
};

typedef NS_OPTIONS(NSUInteger, CUIBlockDescriptionFlags) {
    CUIBlockDescriptionFlagsHasCopyDispose = (1 << 25),
    CUIBlockDescriptionFlagsHasCtor = (1 << 26),
    CUIBlockDescriptionFlagsIsGlobal = (1 << 28),
    CUIBlockDescriptionFlagsHasStret = (1 << 29),
    CUIBlockDescriptionFlagsHasSignature = (1 << 30)
};

@interface CUIBlockInfo ()

@property (nonatomic, strong) id block;
@property (nonatomic, strong) NSMethodSignature *signature;

@end

@implementation CUIBlockInfo

- (NSMethodSignature *)signature {
    if (!_signature) {
        _signature = [self getBlockSignature:self.block];
    }
    return _signature;
}

- (const char *)argumentTypeAtIndex:(NSInteger)index {
    return [self.signature getArgumentTypeAtIndex:index + 1];
}

- (const char *)returnType {
    return [self.signature methodReturnType];
}

- (NSInteger)argumentCount {
    return self.signature.numberOfArguments - 1;
}

- (BOOL)isReturningInt {
    return CUI_CHECK_IS_INT(self.returnType[0]);
}

- (BOOL)isReturningFloat {
    return CUI_CHECK_IS_FLOAT(self.returnType[0]);
}

- (BOOL)isReturningObject {
    return CUI_CHECK_IS_OBJECT(self.returnType[0]);
}

- (BOOL)isAcceptingIntAtIndex:(NSInteger)index {
    return index < self.signature.numberOfArguments - 1? CUI_CHECK_IS_INT([self argumentTypeAtIndex:index][0]): NO;
}

- (BOOL)isAcceptingFloatAtIndex:(NSInteger)index {
    return index < self.signature.numberOfArguments - 1? CUI_CHECK_IS_FLOAT([self argumentTypeAtIndex:index][0]): NO;
}

- (BOOL)isAcceptingObjectAtIndex:(NSInteger)index {
    return index < self.signature.numberOfArguments - 1? CUI_CHECK_IS_OBJECT([self argumentTypeAtIndex:index][0]): NO;
}


typedef struct _AspectBlock {
    __unused Class isa;
    int flags;
    __unused int reserved;
    void (__unused *invoke)(struct _AspectBlock *block, ...);
    struct {
        unsigned long int reserved;
        unsigned long int size;
        // requires AspectBlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires AspectBlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *AspectBlockRef;


- (NSMethodSignature *)getBlockSignature:(id)block {
    struct CUI_block_layout *layout = (__bridge struct CUI_block_layout *)block;
    CUIBlockDescriptionFlags flags = layout->flags;
    
    if (flags & CUIBlockDescriptionFlagsHasSignature) {
        void *signatureLocation = layout->descriptor;
        signatureLocation += sizeof(unsigned long int);
        signatureLocation += sizeof(unsigned long int);
        
        if (flags & CUIBlockDescriptionFlagsHasCopyDispose) {
            signatureLocation += sizeof(void(*)(void *dst, void *src));
            signatureLocation += sizeof(void (*)(void *src));
        }
        
        const char *signature = (*(const char **)signatureLocation);
        return [NSMethodSignature signatureWithObjCTypes:signature];
        
    } else {
        return nil;
    }
}

- (instancetype)initWithBlock:(id)block {
    self = [super init];
    self.block = block;
    return self;
}
@end
