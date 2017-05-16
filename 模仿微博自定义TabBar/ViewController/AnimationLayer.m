
//
//  AnimationLayer.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/9.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "AnimationLayer.h"
@interface AnimationLayer()
@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CAShapeLayer *heartpPathLayer;//💖的路线
@property (nonatomic, retain) CALayer *penLayer;
@end
@implementation AnimationLayer

+ (void)createAnimationLayerWithString:(NSString *)string andRect:(CGRect)rect andView:(UIView *)view andFont:(UIFont *)ui_font andStrokeColor:(UIColor *)color{
    AnimationLayer *animationLayer = [AnimationLayer layer];
    animationLayer.frame = rect;
    [view.layer addSublayer:animationLayer];
    
    if (animationLayer.pathLayer != nil) {
        [animationLayer.penLayer removeFromSuperlayer];
        [animationLayer.pathLayer removeFromSuperlayer];
        [animationLayer.heartpPathLayer removeFromSuperlayer];
        animationLayer.heartpPathLayer = nil;
        animationLayer.pathLayer = nil;
        animationLayer.penLayer = nil;
    }
    
    //字体
    CTFontRef font = CTFontCreateWithName((CFStringRef)ui_font.fontName, ui_font.pointSize, NULL);
    //CGPathCreateMutable 构造路径
    CGMutablePathRef letters = CGPathCreateMutable();
    //这里设置画线的字体和大小
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font,kCTFontAttributeName ,nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    //for each RUN 每次运行
    for (CFIndex runIndex = 0;runIndex < CFArrayGetCount(runArray) ; runIndex ++) {
        
        //获取此运行字体
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        //运行中的每个字形
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex ++) {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
     CFRelease(line);
    
    //贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    //CAShapeLayer 是个神奇的东西，给它一个path它就能变成你想要的形状
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height-230);
    pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [color CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 1.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    [animationLayer addSublayer:pathLayer];
    animationLayer.pathLayer = pathLayer;
    
    UIImage *penImage = [UIImage imageNamed:@""];
    
    
    CGFloat spaceWidth = 20;
    //半径
    CGFloat radius  = MIN((rect.size.width - spaceWidth*2)/4, (rect.size.height - spaceWidth*2)/4);
    
    //左侧圆心 位于左侧边距 + y半径宽度
    CGPoint leftCenter = CGPointMake(spaceWidth+radius, radius/2);
    //右侧圆心 位于左侧圆心的右侧 距离为两倍半径
    CGPoint rightCenter = CGPointMake(spaceWidth+radius*3, radius/2);
    //左侧半圆
    UIBezierPath *heartLine = [UIBezierPath bezierPath];
    [heartLine addArcWithCenter:leftCenter radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
    //曲线连接到新的底部顶点 为了弧线的效果，控制点，坐标x为总宽度减spaceWidth，刚好可以相切，平滑过度 y可以根据需要进行调整，y越大，所画出来的线越接近内切圆弧
    [heartLine addQuadCurveToPoint:CGPointMake((rect.size.width/2), rect.size.height - spaceWidth*6) controlPoint:CGPointMake(spaceWidth, rect.size.height*0.3)];
    
    CAShapeLayer *heartpathLayer = [CAShapeLayer layer];
    heartpathLayer.path = heartLine.CGPath;
    heartpathLayer.strokeColor = [[UIColor redColor] CGColor];
    heartpathLayer.fillColor = nil;
    heartpathLayer.lineWidth = 1.0f;
    heartpathLayer.lineJoin = kCALineJoinRound;
    [animationLayer addSublayer:heartpathLayer];
    
    CABasicAnimation *heartPathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    heartPathAnimation.duration = 5.0;
    heartPathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    heartPathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [heartpathLayer addAnimation:heartPathAnimation forKey:@"strokeEnd"];
    
    //右侧半圆
    UIBezierPath *heartRightLine = [UIBezierPath bezierPath];
    [heartRightLine addArcWithCenter:rightCenter radius:radius startAngle:M_PI endAngle:0 clockwise:YES];
    [heartRightLine addQuadCurveToPoint:CGPointMake((rect.size.width/2), rect.size.height-spaceWidth*6) controlPoint:CGPointMake(rect.size.width - spaceWidth, rect.size.height*0.3)];
    CAShapeLayer *heartRightLayer = [CAShapeLayer layer];
    heartRightLayer.path = heartRightLine.CGPath;
    heartRightLayer.strokeColor = [[UIColor redColor] CGColor];
    heartRightLayer.fillColor = nil;
    heartRightLayer.lineJoin = kCALineJoinRound;
    [animationLayer addSublayer:heartRightLayer];
    
    CABasicAnimation *heartRigthAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    heartRigthAnimation.duration = 5.0;
    heartRigthAnimation.fromValue = @(0);
    heartRigthAnimation.toValue = @(1.0);
    [heartRightLayer addAnimation:heartRigthAnimation forKey:@"strokeEnd"];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [animationLayer.pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CAKeyframeAnimation *penAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    penAnimation.duration = 5.0;
    penAnimation.path = animationLayer.pathLayer.path;
    penAnimation.calculationMode = kCAAnimationPaced;
    penAnimation.delegate = animationLayer;
    [animationLayer.penLayer addAnimation:penAnimation forKey:@"position"];
}

@end
