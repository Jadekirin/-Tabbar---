//
//  ShowImageView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/4.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "ShowImageView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation ShowImageView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame =frame;
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

- (NSMutableArray *)ImageArray{
    if (!_ImageArray) {
        _ImageArray = [NSMutableArray new];
    }
    return _ImageArray;
}

- (void)initSrollerView{
    self.ScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    self.ScrollView.contentSize = CGSizeMake(self.bounds.size.width * _ImageArray.count, 0);
    self.ScrollView.scrollEnabled = YES;
    self.ScrollView.showsHorizontalScrollIndicator = YES;
    self.ScrollView.pagingEnabled = YES;
    for (int i = 0; i<_ImageArray.count; i++) {
        self.ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth , 0, kScreenWidth, kScreenHeight)];
        self.ImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.ImageView.image = [UIImage imageNamed:_ImageArray[i]];
         [self.ScrollView addSubview:self.ImageView];
    }
    
    self.ScrollView.contentOffset = CGPointMake(kScreenWidth * _index, 0);
   
    [self addSubview:self.ScrollView];
    
}
@end
