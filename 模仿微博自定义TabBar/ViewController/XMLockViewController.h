//
//  XMLockViewController.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  控制器类型
 */
typedef NS_ENUM(NSInteger,XMLockType) {
    XMLockTypeCreate,  ///< 创建密码控制器
    XMLockTypeModify,  ///< 修改密码控制器
    XMLockTypeVerify,  ///< 验证密码控制器
    XMLockTypeRemove   ///< 移除密码控制器
};

/**
 * 控制器弹出方式
 */
typedef NS_ENUM(NSInteger, XMLockAppearMode) {
    XMLockAppearModePush,
    XMLockAppearModePresent
};

@protocol XMLockViewControllerDelegate <NSObject>

/**
 *  密码创建成功
 *
 *  param passcode
 */
- (void)passcodeDidCreate:(NSString *)passcode;

/**
 *  密码修改成功
 *
 *  param passcode
 */
- (void)passcodeDidModify:(NSString *)passcode;

/**
 *  密码验证成功
 *
 *  param passcode
 */
- (void)passcodeDidVerify:(NSString *)passcode;

/**
 *  密码移除成功
 */
- (void)passcodeDidRemove;

@end

@interface XMLockViewController : UIViewController

@property (nonatomic, weak) id <XMLockViewControllerDelegate> delegate;

- (instancetype)initWithDelegate:(id<XMLockViewControllerDelegate>)delegate type:(XMLockType)type appearMode:(XMLockAppearMode)appearMode;

@end
