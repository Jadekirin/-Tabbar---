//
//  WXCommentView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/11.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "WXCommentView.h"

@interface WXCommentView ()

@property (nonatomic ,strong) NSArray *likeItemsArray;
@property (nonatomic ,strong) NSArray *commentItemsArray;
@property (nonatomic, strong) UIImageView *bgImageView;



@property (nonatomic, strong) UIView *likeLableBottomLine;
@property (nonatomic, strong) NSMutableArray *commentLabelArray;



@end

@implementation WXCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup{
    
    _bgImageView = [UIImageView new];
    UIImage *image = [[[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _bgImageView.image = image;
    _bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgImageView];
    
    
    
}

@end
