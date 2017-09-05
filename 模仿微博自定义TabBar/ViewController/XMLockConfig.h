
//
//  XMLockConfig.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef XMLockConfig_h
#define XMLockConfig_h

// 背景颜色
#define XM_LOCK_COLOR_BACKGROUND [UIColor whiteColor]

// 正常主题颜色
#define XM_LOCK_COLOR_NORMAL [UIColor blueColor]

// 错误提示颜色
#define XM_LOCK_COLOR_ERROR [UIColor redColor]

// 重设按钮颜色
#define XM_LOCK_COLOR_BUTTON [UIColor grayColor]
/**
 *  圆圈边框粗细(指示器和九宫格的一样粗细)
 */
static const CGFloat kCircleWidth = 0.5f;
/**
 *  圆圈选中效果中心点和圆圈比例
 */
static const CGFloat kCircleCenterRatio = 0.4f;
/**
 *  指示器轨迹粗细
 */
static const CGFloat kIndicatorTrackWidth = 0.5f;

/**
 *  最少连接个数
 */
static const NSInteger kConnectionMinNum = 4;
/**
 *  指示器大小
 */
static const CGFloat kIndicatorSideLength = 30.f;
/**
 *  指示器标签基数(不建议更改)
 */
static const NSInteger kIndicatorLevelBase = 1000;
/**
 *  九宫格大小
 */
static const CGFloat kSudokoSideLength = 300.f;
/**
 *  九宫格标签基数(不建议更改)
 */
static const NSInteger kSudokoLevelBase = 2000;
/**
 *  九宫格轨迹粗细
 */
static const CGFloat kSudokoTrackWidth = 4.f;

/**
 *  手势解锁开关键(不建议更改)
 */
static NSString * const kXMLockGestureUnlockEnabled = @"XMLockGestureUnlockEnabled";
/**
 *  手势密码键(不建议更改)
 */
static NSString * const kXMLockPasscode = @"JinnLockPasscode";
/**
 *  提示文本
 */
static NSString * const XMLockTouchIdText  = @"指纹验证";
static NSString * const XMLockResetText    = @"重新设置";
static NSString * const XMLockNewText      = @"请设置新密码";
static NSString * const XMLockVerifyText   = @"请输入密码";
static NSString * const XMLockAgainText    = @"请再次确认新密码";
static NSString * const XMLockNotMatchText = @"两次密码不匹配";
static NSString * const XMLockReNewText    = @"请重新设置新密码";
static NSString * const XMLockReVerifyText = @"请重新输入密码";
static NSString * const XMLockOldText      = @"请输入旧密码";
static NSString * const XMLockOldErrorText = @"密码不正确";
static NSString * const XMLockReOldText    = @"请重新输入旧密码";

#define XM_LOCK_NOT_ENOUGH [NSString stringWithFormat:@"最少连接%ld个点，请重新输入", (long)kConnectionMinNum]

#endif /* XMLockConfig_h */
