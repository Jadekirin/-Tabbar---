
//
//  PhotoContainerView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/11.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "PhotoContainerView.h"
#import "UIView+SDAutoLayout.h"
@interface PhotoContainerView ()

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation PhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setup{
    NSMutableArray *tmp = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        [tmp addObject:imageView];
        [self addSubview:imageView];
    }
    self.imageViewsArray = [tmp copy];
}

- (void)setPicPathStringArray:(NSArray *)picPathStringArray{
    
    _picPathStringArray = picPathStringArray;
    
    //9张图片 隐藏用不到的图片的位置
    for (long i = _picPathStringArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *image = self.imageViewsArray[i];
        image.hidden = YES;
    }
    if (_picPathStringArray.count == 0) {
        self.height = 0;
        self.fixedHeight = 0;
        return;
    }
    CGFloat ItemW = [self itemWidthForPicPathArray:_picPathStringArray];
    CGFloat itemH = 0;
    if (_picPathStringArray.count == 1) {
        UIImage *image = [UIImage imageNamed:_picPathStringArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * ItemW ;
                }
        }else{
            itemH = ItemW;
        };
        long perRowItemCount = [self perRowItemCountForPicPathArrar:_picPathStringArray];
        
        CGFloat margin = 5;
        //enumerateObjectsUsingBlock 遍历数组  数据大的时候用比较好
        [_picPathStringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            long columIndex = idx % perRowItemCount;//第几个
            long rowIndex = idx / perRowItemCount;//第几行
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            
            imageView.frame = CGRectMake(columIndex * (ItemW + margin), rowIndex * (itemH + margin), ItemW, itemH);
            imageView.image = [UIImage imageNamed:obj];
        }];
        //图片View的总宽度
        CGFloat w = perRowItemCount * ItemW + (perRowItemCount - 1) *margin;
       //ceil 功能:返回大于或者等于指定表达式的最小整数头
        int columCount = ceilf(_picPathStringArray.count * 1.0 / perRowItemCount);
        //图片View的总高度
        CGFloat h = columCount * itemH + (columCount - 1) * margin;
        self.width = w;
        self.height = h;
        
        self.fixedWidth = @(w);
        self.fixedHeight = @(h);
    
    
    
    
    
}

//设置pic的宽度
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array{
    if (array.count == 1) {
        return 120;
    }else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}
// 一行显示几个图片
- (NSInteger)perRowItemCountForPicPathArrar:(NSArray *)array{
    if (array.count < 3) {
        return array.count;
    }else if (array.count <= 4){
        return 2;
    }else{
        return 3;
    }
}


@end
