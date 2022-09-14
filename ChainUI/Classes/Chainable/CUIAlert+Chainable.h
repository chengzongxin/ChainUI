//
//  CUIAlert+Chainable.h
//  ChainUI
//
//  Created by Joe.cheng on 2021/3/1.
//

#import "CUIAlert.h"
#import "CUIDefs.h"

#define Alert           [[CUIAlert alloc] initWithStyle:UIAlertControllerStyleAlert]
#define ActionSheet     [[CUIAlert alloc] initWithStyle:UIAlertControllerStyleActionSheet]

typedef CUIAlert *__nullable(^CUIChainableCUIAlertActionBlock)(__nullable id, __nullable id);
typedef UIAlertController *__nullable(^CUIAlertShowBlock)(void);

/**
 * Examples:
    Alert.title(@"Greeting").message(@"A greeting from little green man.").action(@"Cool", nil).tint(@"green").show();
 
    ActionSheet.title(@"Zombie atatck").message(@"Choose your weapon!").action(@"Gun", ^{
        Log(@"Gun");
    }).action(@"Chainsaw", ^{
        Log(@"Chainsaw");
    }).destructiveAction(@"Nuke", ^{
        Log(@"Nuke");
    }).cancelAction(@"Give up").show();
 */

NS_ASSUME_NONNULL_BEGIN

@interface CUIAlert (Chainable)

/**
 * Alert title or ActionSheet title.
 * Usages: .title(@"Put title here")
 */
CUI_ALERT_PROP(Object)          title;

/**
 * Alert message or ActionShett message.
 * Usages: .message(@"Put message here")
 */
CUI_ALERT_PROP(Object)          message;

/**
 * Adding a default action with title and callback block.
 * Usages: .action(@"Option1", ^{...}).action(@"Option2", ^{...})
 */
CUI_ALERT_PROP(Action)          action;

/**
 * Adding a cancel action with title and a optional callback block.
 * Usages: .cancelAction(@"Cancel"), .cancelAction(@"Cancel", ^{...})
 */
CUI_ALERT_PROP(ObjectList)      cancelAction;

/**
 * Adding a destructive action with title and callback block.
 * Usages: .destructiveAction(@"Delete", ^{...})
 */
CUI_ALERT_PROP(Action)          destructiveAction;

/**
 * tintColor
 * You can use tint to change action button's title color.
 * tint use Color() internally, so it can take any kind of arguments that Color() supported.
 * Usages: .tint(@"red"), .tint(@"#F00"), .tint(@"255,0,0"), .tint(colorObject), etc.
 * See UIColor+CUIChainable.h for more information.
 */
CUI_ALERT_PROP(Object)          tint;

/**
 * Present alert/actionsheet in top visible view controller.
 * You must call show() in the end in order to present alert/actionsheet.
 * Usages: .show()
 */
CUI_READONLY CUIAlertShowBlock  show;

#define cancelAction(...)   cancelAction(__VA_ARGS__, nil)
@end

NS_ASSUME_NONNULL_END
