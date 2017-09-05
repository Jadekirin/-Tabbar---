//
//  XMLockTool.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "XMLockTool.h"
@implementation XMLockTool

+ (BOOL)isGestureUnlockEnabled{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kXMLockGestureUnlockEnabled];
}

+ (void)setGestureUnlockEnabled:(BOOL)enabled{
    [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:kXMLockGestureUnlockEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  当前已经设置的手势密码
 *
 *  return
 */
+ (NSString *)currentGesturePasscode
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kXMLockPasscode];
}
/**
 *  设置新的手势密码
 *
 *  param passcode
 */
+ (void)setGesturePasscode:(NSString *)passcode
{
    [[NSUserDefaults standardUserDefaults] setObject:passcode forKey:kXMLockPasscode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
