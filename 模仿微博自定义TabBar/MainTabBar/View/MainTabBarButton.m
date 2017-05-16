//
//  MainTabBarButton.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/5.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "MainTabBarButton.h"

#define TabBarButtonImageRation 0.6

@implementation MainTabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //只需设置一次
       // contentMode 这个属性是用来设置图片的显示方式
        self.imageView.contentMode = UIViewContentModeBottom;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor colorWithRed:205/255.0f green:89/255.0f blue:75/255.0f alpha:1.0] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor colorWithRed:117/255.0f green:117/255.0f blue:117/255.0f alpha:1.0] forState:UIControlStateNormal];
    }
    return self;
}

//布局image和label的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * TabBarButtonImageRation;
    
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * TabBarButtonImageRation;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

//赋值button的image和title
- (void)setTabBarItem:(UITabBarItem *)tabBarItem{
    _tabBarItem = tabBarItem;
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
}

@end
