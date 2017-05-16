//
//  LabelSubView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/10.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "LabelSubView.h"


#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
//#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface LabelSubView ()
@property (nonatomic,strong) NSMutableArray *RigthLabelArray;
@property (nonatomic,strong) NSMutableArray *LeftLabelArray;
@end
@implementation LabelSubView

- (instancetype)initWithStr:(NSString*)str{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSMutableArray *)RigthLabelArray{
    if (!_RigthLabelArray) {
        _RigthLabelArray = [NSMutableArray array];
    }
    return _RigthLabelArray;
}
- (NSMutableArray *)LeftLabelArray{
    if (!_LeftLabelArray) {
        _LeftLabelArray = [NSMutableArray array];
    }
    return _LeftLabelArray;
}

- (void)SetUplabelWithRightLabel:(NSString *)rightStr LeftLabel:(NSString *)leftStr{
    NSInteger width = 25;
    NSInteger space = 10;
    NSMutableArray *rightArr = [NSMutableArray array];
    NSInteger length = [rightStr length];
    for (int i = 0; i<length; i++) {
        NSString *str = [rightStr substringWithRange:NSMakeRange(i, 1)];
        [rightArr addObject:str];
        
    }
    for (NSInteger index = 0; index < rightArr.count; index++) {
        UILabel *rightlabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/6-width, ScreenHeight/2.5 + (width + space)*index - 40, width, width)];
        rightlabel.text = rightArr[index];
        rightlabel.textColor = [self randomColor];
        rightlabel.font = [UIFont systemFontOfSize:25];
        rightlabel.transform = CGAffineTransformMakeTranslation(-100, 0);
        [self addSubview:rightlabel];
        [self.RigthLabelArray addObject:rightlabel];
    }
    
    NSMutableArray *leftArr = [NSMutableArray array];
    NSInteger length1 = [leftStr length];
    for (int i = 0; i<length1; i++) {
        NSString *str = [leftStr substringWithRange:NSMakeRange(i, 1)];
        [leftArr addObject:str];
        
    }
    for (NSInteger index = 0; index < leftArr.count; index++) {
        UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth -ScreenWidth/6, ScreenHeight/2.5 + (width + space)*index- 40, width, width)];
        leftlabel.text = leftArr[index];
        leftlabel.textColor = [self randomColor];
        leftlabel.font = [UIFont systemFontOfSize:25];
        leftlabel.transform = CGAffineTransformMakeTranslation(ScreenWidth+100, 0);
        [self addSubview:leftlabel];
        [self.RigthLabelArray addObject:leftlabel];
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

- (void)showLabel{
    
    for (NSInteger index = 0; index < self.RigthLabelArray.count; index++) {
        UILabel *label = self.RigthLabelArray[index];
        [UIView animateWithDuration:0.5 delay:0.3*index usingSpringWithDamping:0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}
- (UIColor *)randomColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@end
