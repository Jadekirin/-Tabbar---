//
//  FlowCell.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
- (void)SetData:(NSString *)ImgStr;

@end
