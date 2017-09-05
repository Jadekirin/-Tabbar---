//
//  XMLockSudoko.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/9.
//  Copyright © 2017年 maweilong. All rights reserved.


#import "XMLockSudoko.h"
#import "XMLockConfig.h"
#import "XMLockCricle.h"
@interface XMLockSudoko ()

@property (nonatomic,strong) NSMutableArray *circleArray;
@property (nonatomic,strong) NSMutableArray *selectedCirleArray;
@property (nonatomic,assign) CGFloat circleMargin;
@property (nonatomic,assign) CGPoint currentPoint;
@property (nonatomic, assign, getter = isErrorPassword) BOOL errorPasscode;
@property (nonatomic,assign,getter=isDrawing) BOOL drawing;
@end

@implementation XMLockSudoko

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
        [self createCircles];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds   = YES;
    
    self.circleArray = [NSMutableArray new];
    self.selectedCirleArray = [NSMutableArray new];
    self.circleMargin = kSudokoSideLength / 15;
}

- (void)createCircles{
    for (int i = 0; i < 9; i++) {
        float x = self.circleMargin * (4.5 * (i % 3) + 1.5);
        float y = self.circleMargin * (4.5 * (i / 3) + 1.5);
        
        XMLockCricle *circle = [[XMLockCricle alloc] initWithDiameter:self.circleMargin * 3];
        [circle setTag:kSudokoLevelBase + i];
        [circle setFrame:CGRectMake(x, y, self.circleMargin * 3, self.circleMargin * 3)];
        [self.circleArray addObject:circle];
        [self addSubview:circle];
    }
}

#pragma mark - Action 手势开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.drawing = NO;
    
    [self updateTrack:[[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.drawing = YES;
    [self updateTrack:[[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endTrack];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [self endTrack];
}



#pragma mark - Private
//更新路径
- (void)updateTrack:(CGPoint)point{
    self.currentPoint = point;
    for (XMLockCricle *circle in self.circleArray) {
        CGFloat xABS = fabs(point.x - circle.center.x);
        CGFloat yABS = fabs(point.y - circle.center.y);
        //半径
        CGFloat radius = self.circleMargin * 3 / 2;
        if (xABS <= radius && yABS <= radius) {
            if (circle.state == XMLockCircleStateNormal) {
                [circle UpdateCricleState:XMLockCircleStateSelected];
                [self.selectedCirleArray addObject:circle];
            }
            break;
        }
    }
    //UIView刷新
    [self setNeedsDisplay];
}
//结束路径
- (void)endTrack{
    self.drawing = NO;
    //手势密码字符串
    NSString *passcode = @"";
    for (int i = 0 ; i < self.selectedCirleArray.count; i++) {
        XMLockCricle *circle = self.selectedCirleArray[i];
        passcode = [passcode stringByAppendingFormat:@"%ld",circle.tag - kSudokoLevelBase];
    }
    //手势结束就清空
    [self reset];
    
    if ([_delegate respondsToSelector:@selector(sudoko:passcodeDidCreate:)]) {
        [_delegate sudoko:self passcodeDidCreate:passcode];
    }
    
}

#pragma mark - Public
- (void)reset{
    if (!self.drawing) {
        self.errorPasscode = NO;
        for (XMLockCricle *circle in self.circleArray) {
            [circle UpdateCricleState:XMLockCircleStateNormal];
        }
        [self.selectedCirleArray removeAllObjects];
        [self setNeedsDisplay];
    }
}

- (void)showErrorPasscode:(NSString *)errorPasscode{
    self.errorPasscode = YES;
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:errorPasscode.length];
    for (int i = 0; i < errorPasscode.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [errorPasscode substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [self.circleArray[number.intValue] UpdateCricleState:XMLockCircleStateError];
        [self.selectedCirleArray addObject:self.circleArray[number.intValue]];
    }
    [self setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reset];
    });
}
#pragma mark - Draw
//绘图
- (void)drawRect:(CGRect)rect{
    if (self.selectedCirleArray.count == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kSudokoTrackWidth);
    self.errorPasscode ? [XM_LOCK_COLOR_ERROR set] : [XM_LOCK_COLOR_NORMAL set];
    CGPoint addLines[9];
    int count = 0;
    for (XMLockCricle *circle in self.selectedCirleArray) {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
    
    if (!self.errorPasscode) {
        UIButton *lastButton = self.selectedCirleArray.lastObject;
        CGContextMoveToPoint(context,lastButton.center.x, lastButton.center.y);
        CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
        CGContextStrokePath(context);
    }
    
}

@end
