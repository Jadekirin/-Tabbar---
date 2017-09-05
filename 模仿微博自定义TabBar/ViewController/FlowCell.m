//
//  FlowCell.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FlowCell.h"



@implementation FlowCell

- (void)SetData:(NSString *)ImgStr{
    [self.imageView removeFromSuperview];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height);
    self.imageView.image = [UIImage imageNamed:ImgStr];
    [self addSubview:self.imageView];
//    [ImageView sizeToFit];
}



@end
