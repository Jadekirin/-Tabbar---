//
//  ShowImageView.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/4.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageView : UIView

@property (nonatomic,strong) UIScrollView *ScrollView;
@property (nonatomic,strong) UIImageView *ImageView;
@property (nonatomic,strong) NSMutableArray *ImageArray;
@property (nonatomic) NSInteger index;
- (void)initSrollerView;
@end
