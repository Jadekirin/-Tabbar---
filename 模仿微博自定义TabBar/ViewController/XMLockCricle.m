 //
//  XMLockCricle.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "XMLockCricle.h"
@implementation XMLockCricle


- (instancetype)initWithDiameter:(CGFloat)diameter{
    self = [super initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.diameter = diameter;
        self.state = XMLockCircleStateNormal;
    }
    return self;
}

- (void)UpdateCricleState:(XMLockCricleState)state{
    [self setState:state];
    [self setNeedsDisplay];
}

/**
 *  drawRect: 绘画
 */
- (void)drawRect:(CGRect)rect{
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kCircleWidth);
    
    switch (self.state) {
        case XMLockCircleStateNormal:
            [self drawEmptyCircleWithContext:context rect:CGRectMake(kCircleWidth /2, kCircleWidth/2, self.diameter - kCircleWidth, self.diameter - kCircleWidth) strokeColor:XM_LOCK_COLOR_NORMAL fillColor:XM_LOCK_COLOR_BACKGROUND];
            break;
            
        case XMLockCircleStateSelected:
            [self drawCenterCircleWithContext:context rect:CGRectMake(kCircleWidth / 2, kCircleWidth / 2, self.diameter - kCircleWidth, self.diameter - kCircleWidth) centerRect:CGRectMake(self.diameter * (0.5 - kCircleCenterRatio / 2), self.diameter * (0.5 - kCircleCenterRatio / 2), self.diameter * kCircleCenterRatio, self.diameter * kCircleCenterRatio) strokeColor:XM_LOCK_COLOR_NORMAL fillColor:XM_LOCK_COLOR_BACKGROUND];
            break;
    
        case XMLockCircleStateFill:
        {
            [self drawSolidCircleWithContext:context
                                        rect:CGRectMake(kCircleWidth / 2,
                                                        kCircleWidth / 2,
                                                        self.diameter - kCircleWidth,
                                                        self.diameter - kCircleWidth)
                                 strokeColor:XM_LOCK_COLOR_NORMAL];
        }
        break;
    case XMLockCircleStateError:
        {
            [self drawCenterCircleWithContext:context
                                         rect:CGRectMake(kCircleWidth / 2,
                                                         kCircleWidth / 2,
                                                         self.diameter - kCircleWidth,
                                                         self.diameter - kCircleWidth)
                                   centerRect:CGRectMake(self.diameter * (0.5 - kCircleCenterRatio / 2),
                                                         self.diameter * (0.5 - kCircleCenterRatio / 2),
                                                         self.diameter * kCircleCenterRatio,
                                                         self.diameter * kCircleCenterRatio)
                                  strokeColor:XM_LOCK_COLOR_ERROR
                                    fillColor:XM_LOCK_COLOR_BACKGROUND];
        }
        break;
    default:
        break;
    }
}


/**
 *  空心圆环
 *
 *  param context
 *  param rect
 *  param strokeColor
 *  param fillColor
 */
- (void)drawEmptyCircleWithContext:(CGContextRef)context rect:(CGRect)rect strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor{
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);//去空
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/**
 *  实心圆
 *
 *  param context
 *  param rect
 *  param strokeColor
 */
- (void)drawSolidCircleWithContext:(CGContextRef)context rect:(CGRect)rect strokeColor:(UIColor *)strokeColor{
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
}
/**
 *  圆环 + 中心小圆
 *
 *  param context
 *  param rect
 *  param centerRect
 *  param strokeColor
 *  param fillColor
 */
- (void)drawCenterCircleWithContext:(CGContextRef)context
                               rect:(CGRect)rect
                         centerRect:(CGRect)centerRect
                        strokeColor:(UIColor *)strokeColor
                          fillColor:(UIColor *)fillColor
{
    //圆环
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //中心小圆
    CGContextSetFillColorWithColor(context, strokeColor.CGColor);
    CGContextAddEllipseInRect(context, centerRect);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
