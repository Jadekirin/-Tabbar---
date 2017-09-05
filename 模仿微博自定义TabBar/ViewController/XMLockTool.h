//
//  XMLockTool.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLockConfig.h"
@interface XMLockTool : NSObject
/**
 *  是否允许手势解锁(应用级别的)
 *
 *  return
 */
+ (BOOL)isGestureUnlockEnabled;

/**
 *  设置是否允许手势解锁功能
 *
 *  param enabled
 */
+ (void)setGestureUnlockEnabled:(BOOL)enabled;

/**
 *  当前已经设置的手势密码
 *
 *  return
 */
+ (NSString *)currentGesturePasscode;
/**
 *  设置新的手势密码
 *
 *  param passcode
 */
+ (void)setGesturePasscode:(NSString *)passcode;
@end
