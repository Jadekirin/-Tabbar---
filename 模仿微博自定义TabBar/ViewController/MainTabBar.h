//
//  MainTabBar.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/5.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar;
@protocol MainTabBarDelegate <NSObject>

- (void)tabBar:(MainTabBar *)tabBar didSelectButtonFrom:(long)fromBtnTag to:(long)toBtnTag;

- (void)tabBarCliclMiddleButton:(MainTabBar *)tabBar;

@end


@interface MainTabBar : UIView

@property (nonatomic,weak)  id<MainTabBarDelegate> delegate;
- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;

@end
