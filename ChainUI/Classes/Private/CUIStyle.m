//
//  CUIStyle.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/2/27.
//

#import "CUIStyle.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

static NSMutableDictionary *cui_styleDict = nil;

@interface CUIStyle ()

@property (nonatomic, strong) NSMutableArray *chainableProperties;

@end

@implementation CUIStyle

- (NSMutableArray *)chainableProperties {
    if (!_chainableProperties) {
        _chainableProperties = [NSMutableArray array];
    }
    return _chainableProperties;
}

- (void)setObjectValue:(id)value forKey:(NSString *)key {
    if (value && key) {
        
        NSDictionary *hasDict;
        for (NSDictionary *dict in self.chainableProperties) {
            if ([dict[@"key"] isEqualToString:key]) {
                hasDict = dict;
            }
        }
        if (hasDict) {
            [self.chainableProperties removeObject:hasDict];
        }
        
        [self.chainableProperties addObject:@{@"key": key, @"value": value}];
    }
}

- (void)setIntValue:(NSInteger)value forKey:(NSString *)key {
    [self setObjectValue:@(value) forKey:key];
}

- (void)setFloatValue:(CGFloat)value forKey:(NSString *)key {
    [self setObjectValue:@(value) forKey:key];
}

- (void)setPointValue:(CGPoint)value forKey:(NSString *)key {
    [self setObjectValue:[NSValue valueWithCGPoint:value] forKey:key];
}

- (void)setSizeValue:(CGSize)value forKey:(NSString *)key {
    [self setObjectValue:[NSValue valueWithCGSize:value] forKey:key];
}

- (void)setRectValue:(CGRect)value forKey:(NSString *)key {
    [self setObjectValue:[NSValue valueWithCGRect:value] forKey:key];
}

- (void)setFloatListValue:(CUIFloatList)flostList forKey:(NSString *)key {
    id value = [NSValue valueWithBytes:&flostList objCType:@encode(CUIFloatList)];
    [self setObjectValue:value forKey:key];
}

- (void)addMethodWithName:(NSString *)name {
    if (name) {
        [self.chainableProperties addObject:@{@"method": name}];
    }
}

- (void)applyToItem:(id)item {
    for (NSDictionary *dict in self.chainableProperties) {
        id key = dict[@"key"];
        id object = dict[@"value"];
        id methodName = dict[@"method"];
        
        if (methodName) {
            SEL sel = NSSelectorFromString(methodName);
            if ([item respondsToSelector:sel]) {
                [item performSelector:sel withObject:nil];
            }
            continue;
        }
        
        SEL sel = NSSelectorFromString(key);
        
        if ([key isEqualToString:@"color"] && [item isKindOfClass:UILabel.class]) {
            id block = [item performSelector:NSSelectorFromString(@"txtColor") withObject:nil];
            if (CUI_IS_BLOCK(block)) {
                ((CUIObjectBlock)block)(object);
            }
        }
        
        if ([key isEqualToString:@"layer.borderWidth"]) {
            if ([item isKindOfClass:UIView.class]) {
                [item setValue:object forKeyPath:key];
            }
            continue;
            
        } else if ([key isEqualToString:@"layer.borderColor"]) {
            if ([item isKindOfClass:UIView.class]) {
                [item setValue:object forKeyPath:key];
            }
            continue;
        }
        
        if ([object isKindOfClass:NSNumber.class]) {
            CGFloat value = [object floatValue];
            
            if ([item respondsToSelector:sel]) {
                id block = [item performSelector:sel withObject:nil];
                if (CUI_IS_BLOCK(block)) {
                    ((void (^)(CGFloat))block)(value);
                }
            }
            
        } else if ([object isKindOfClass:NSValue.class]) {
            const char *ocType = [object objCType];
            
#define CALL_METHOD_WITH_VALUE(type, value) \
            if ([item respondsToSelector:sel]) {\
                id block = [item performSelector:sel withObject:nil];\
                if (CUI_IS_BLOCK(block)) {\
                    ((void (^)(type))block)(value);\
                }\
            }
            
#define CALL_STRUCT_METHOD(type)\
            type value = [object type##Value];\
            CALL_METHOD_WITH_VALUE(type, value);
            
            if (CUI_IS_POINT(ocType)) {
                CALL_STRUCT_METHOD(CGPoint);
            } else if (CUI_IS_SIZE(ocType)) {
                CALL_STRUCT_METHOD(CGSize);
            } else if(CUI_IS_RECT(ocType)) {
                CALL_STRUCT_METHOD(CGRect);
            } else if (CUI_IS_INSETS(ocType)) {
                CALL_STRUCT_METHOD(UIEdgeInsets);
            } else if (CUI_IS_FLOAT_LIST(ocType)) {
                CUIFloatList floatList;
                [object getValue:&floatList];
                CALL_METHOD_WITH_VALUE(CUIFloatList, floatList);
            } else {
//                Log(ocType);
            }
            
        } else {
            if ([item respondsToSelector:sel]) {
                id block = [item performSelector:sel withObject:nil];
                if (CUI_IS_BLOCK(block)) {
                    ((CUIObjectBlock)block)(object);
                }
            }
        }
    }
}

+ (instancetype)styleWithKey:(id <NSCopying>)key {
    return cui_styleDict[key];
}

+ (instancetype)createStyleWithKey:(id <NSCopying>)key {
    CUIStyle *style = [CUIStyle new];
    if (!cui_styleDict) cui_styleDict = [NSMutableDictionary dictionary];
    if (key) cui_styleDict[key] = style;
    return style;
}

+ (instancetype)createStyleWithKeys:(NSArray *)keys {
    return [self createStyleWithKey:keys.firstObject];
}

@end
