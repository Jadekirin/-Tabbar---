//
//  XMLockIndicator.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/22.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "XMLockIndicator.h"
#import "XMLockConfig.h"
#import "XMLockCricle.h"
@interface XMLockIndicator()
@property (nonatomic,strong) NSMutableArray *circleArray;
@property (nonatomic,strong) NSMutableArray *selectedCirleArray;
@property (nonatomic,assign) CGFloat circleMargin;
@end

@implementation XMLockIndicator

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
        [self createCricle];
    }
    return self;
}


- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    self.circleArray = [NSMutableArray new];
    self.selectedCirleArray = [NSMutableArray new];
    self.circleMargin = kIndicatorSideLength / 15;
}

- (void)createCricle{
    for (int i = 0; i < 9; i++) {
        float x = self.circleMargin * (4.5 * (i % 3) + 1.5);
        float y = self.circleMargin * (4.5 * (i / 3) + 1.5);
        
        XMLockCricle *circle = [[XMLockCricle alloc] initWithDiameter:self.circleMargin * 3];
        [circle setTag:kSudokoLevelBase + i];
        [circle setFrame:CGRectMake(x, y, self.circleMargin * 3  , self.circleMargin * 3)];
        [self.circleArray addObject:circle];
        [self addSubview:circle];
    }
}
#pragma mark - Public
 
- (void)showPasscode:(NSString *)passcode
{
    [self reset];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:passcode.length];
    for (int i = 0; i < passcode.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [passcode substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [self.circleArray[number.intValue] UpdateCricleState:XMLockCircleStateFill];
        [self.selectedCirleArray addObject:self.circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
}

- (void)reset{
    for (XMLockCricle *circle in self.circleArray) {
        [circle UpdateCricleState:XMLockCircleStateNormal];
    }
    [self.selectedCirleArray removeAllObjects];
}

#pragma mark - Draw
//绘图 划线
- (void)drawRect:(CGRect)rect{
    if (self.selectedCirleArray.count == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kIndicatorTrackWidth);
  
    CGPoint addLines[9];
    int count = 0;
    for (XMLockCricle *circle in self.selectedCirleArray) {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
    
    
    
}

@end
