//
//  AnimationLayer.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/9.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface AnimationLayer : CALayer
/**
 *  字符串画线
 *
 *  @param string    要画的字符串
 *  @param rect      动画位置
 *  @param view      动画所在视图
 *  @param ui_font   动画字体
 *  @param color     字体颜色
 */
+(void)createAnimationLayerWithString:(NSString*)string andRect:(CGRect)rect andView:(UIView*)view andFont:(UIFont*)ui_font andStrokeColor:(UIColor*)color;
@end
