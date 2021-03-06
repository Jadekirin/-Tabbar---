//
//  MainTabBar.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/5.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"
@interface MainTabBar ()

@property (nonatomic,strong) NSMutableArray *tabBarBtnArray;
@property (nonatomic ,weak) UIButton *minddleButton;
@property (nonatomic ,weak) MainTabBarButton *selectedButton;

@end

@implementation MainTabBar

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self SetUpMiddleButton];
    }
    return self;
}

- (void)SetUpMiddleButton{
    UIButton *middleButton = [UIButton new];
    middleButton.adjustsImageWhenHighlighted = NO;
    [middleButton addTarget:self action:@selector(ClickMiddleButton) forControlEvents:UIControlEventTouchUpInside];
    [middleButton setImage:[UIImage imageNamed:@"tabar_plus_normal"] forState:UIControlStateNormal];
    middleButton.bounds = CGRectMake(0, 0, middleButton.currentBackgroundImage.size.width, middleButton.currentBackgroundImage.size.height);
    [self addSubview:middleButton];
    _minddleButton = middleButton;
    
}

//重新布局
- (void)layoutSubviews{
    [super layoutSubviews];
    self.minddleButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
   
    CGFloat BtnY = 0;
    CGFloat BtnW = self.frame.size.width / self.subviews.count;
    CGFloat BtnH = self.frame.size.height;
    
    for (int index = 0; index < self.tabBarBtnArray.count; index ++) {
        CGFloat BtnX = BtnW * index;
        MainTabBarButton *tabBarBtn = self.tabBarBtnArray[index];
        if (index > 1) {
            BtnX += BtnW;
        }
        tabBarBtn.frame = CGRectMake(BtnX, BtnY, BtnW, BtnH);
        tabBarBtn.tag = index;
    }
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem{
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabBarBtnArray.count == 1){
        [self ClickTabBarButton:tabBarBtn];
    }
}

//tabbarBtn 点击事件
- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn{
    
}

//中间button 点击事件
- (void)ClickMiddleButton{

    
}

@end
