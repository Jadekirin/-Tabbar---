//
//  FriendHeaderView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FriendHeaderView.h"
#import "UIView+SDAutoLayout.h"
@interface FriendHeaderView ()
{

    UIImageView *_BgImageView;
    UILabel *_NameLabel;
    UIImageView *_IconImageView;
    
}

@end

@implementation FriendHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _BgImageView = [[UIImageView alloc] init];
    _BgImageView.image = [UIImage imageNamed:@"pbg.jpg"];
    [self addSubview:_BgImageView];
    
    _IconImageView = [UIImageView new];
    _IconImageView.image = [UIImage imageNamed:@"picon.jpg"];
    _IconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _IconImageView.layer.borderWidth = 1.0;
    [self addSubview:_IconImageView];
    
    _NameLabel = [UILabel new];
    _NameLabel.text = @"我是郭德纲";
    _NameLabel.textColor = [UIColor whiteColor];
    _NameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_NameLabel];
    
    
    _BgImageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(-60, 0, 40, 0));
    
    _IconImageView.sd_layout
    .rightSpaceToView(self, 20)
    .bottomSpaceToView(self, 20)
    .widthIs(70)
    .heightIs(70);
    
    [_NameLabel setSingleLineAutoResizeWithMaxWidth:200];
    _NameLabel.sd_layout
    .rightSpaceToView(_IconImageView, 20)
    .bottomSpaceToView(_IconImageView, -40)
    .widthIs(100)
    .heightIs(20);
    
}



@end
