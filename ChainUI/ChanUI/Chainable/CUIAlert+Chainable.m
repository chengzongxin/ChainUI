//
//  CUIAlert+Chainable.m
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIAlert+Chainable.h"
#import "UIColor+Chainable.h"
#import "CUIUtils.h"

@implementation CUIAlert (Chainable)

- (CUIChainableCUIAlertObjectBlock)title{
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"titleObject"]);
}


- (CUIChainableCUIAlertObjectBlock)message{
    CUI_OBJECT_BLOCK([self setValue:value forKey:@"messageObject"]);
}

- (CUIChainableCUIAlertObjectBlock)tint{
    CUI_OBJECT_BLOCK([self setValue:Color(value) forKey:@"tintObject"]);
}

- (CUIChainableCUIAlertActionBlock)action{
    return ^(id titleObject, CUISimpleBlock block) {
        [self addActionWithStyle:UIAlertActionStyleDefault title:titleObject handler:block];
        return self;
    };
}

- (CUIChainableCUIAlertObjectListBlock)cancelAction{
    return ^(id titleObject, ...) {
        CUI_GET_VARIABLE_OBJECT_ARGUMENTS(titleObject);
        [self addActionWithStyle:UIAlertActionStyleCancel title:titleObject handler:arguments.firstObject];
        return self;
    };
}

- (CUIChainableCUIAlertActionBlock)destructiveAction{
    return ^(id titleObject, CUISimpleBlock block) {
        [self addActionWithStyle:UIAlertActionStyleDestructive title:titleObject handler:block];
        return self;
    };
}

- (CUIAlertShowBlock)show {
    return ^ {
        return [self presentInTopViewController];
    };
}
@end
