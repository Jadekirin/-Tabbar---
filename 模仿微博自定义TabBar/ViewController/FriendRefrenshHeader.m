//
//  FriendRefrenshHeader.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FriendRefrenshHeader.h"

#define RefreshHeaderRotateAnimationKey @"RotateAnimationKey"
@implementation FriendRefrenshHeader

{
    CABasicAnimation *_rotateAnimation;
}

+(instancetype)refrenshHeaderWithCenter:(CGPoint)center{
    FriendRefrenshHeader *header = [FriendRefrenshHeader new];
    header.center = center;
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
    self.bounds = imageView.bounds;
    [self addSubview:imageView];
    
    _rotateAnimation = [[CABasicAnimation alloc] init];
    _rotateAnimation.keyPath = @"transfrom.rotation.z";
    _rotateAnimation.fromValue = @0;
    _rotateAnimation.toValue = @(M_PI *2);
    _rotateAnimation.duration = 1.0;
    _rotateAnimation.repeatCount = MAXFLOAT;
    
}

- (void)setRefrenshState:(WXRefreshViewState)refrenshState{
    [super setRefrenshState:refrenshState];
    if (refrenshState == WXRefreshViewStateRefreshing) {
        if (self.refrenshingBlock) {
            self.refrenshingBlock();
        }
        [self.layer addAnimation:_rotateAnimation forKey:RefreshHeaderRotateAnimationKey];
    }else if (refrenshState == WXRefreshViewStateNormal){
        [self.layer removeAnimationForKey:RefreshHeaderRotateAnimationKey];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
        
    }
    
}


@end
