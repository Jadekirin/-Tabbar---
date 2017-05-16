//
//  FriendRefrenshHeader.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendRefreshView.h"

@interface FriendRefrenshHeader : FriendRefreshView

+ (instancetype)refrenshHeaderWithCenter:(CGPoint)center;
@property (nonatomic, copy) void (^refrenshingBlock)();

@end
