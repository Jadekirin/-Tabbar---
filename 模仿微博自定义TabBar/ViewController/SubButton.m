//
//  SubButton.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/9.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "SubButton.h"

@implementation SubButton


- (void)setButtonBackgroungImage:(UIImage*)image WithTitle:(NSString *)title withTitleColor:(UIColor *)color forState:(UIControlState)state{
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setImage:image forState:state];
    [self setTitle:title forState:state];
    [self setTitleColor:color forState:state];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * 0.65;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * 0.4;

    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageX = contentRect.size.width * 0.2;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width * 0.6;
    CGFloat imageH = contentRect.size.height * 0.6;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
