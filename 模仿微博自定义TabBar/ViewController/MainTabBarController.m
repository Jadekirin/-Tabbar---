//
//  MainTabBarController.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/5.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"
#import "TestViewController.h"
#import "MainNavigationController.h"
#import "MainTabBar.h"
#import "SubView.h"
@interface MainTabBarController () <MainTabBarDelegate>

@property (nonatomic, weak) MainTabBar *mainTabBar;
@property (nonatomic,strong) SubView *subView;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpMainTabBar];
    [self SetUpAllControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //移除系统的tabbar
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)SetUpMainTabBar{
    MainTabBar *mainTaBar = [[MainTabBar alloc] init];
    mainTaBar.frame = self.tabBar.bounds;//frame 等于系统tabBar的frame
    mainTaBar.delegate = self;
    [self.tabBar addSubview:mainTaBar];
    _mainTabBar = mainTaBar;
}


- (void)SetUpAllControllers{
    NSArray *titles = @[@"首页", @"信息", @"发现", @"我的"];
    NSArray *images = @[@"tabbar_home_normal", @"tabbar_voucher_normal", @"tabbar_find_normal", @"tabbar_my_normal"];
    NSArray *selectedImages = @[@"tabbar_home_select", @"tabbar_voucher_select", @"tabbar_find_select", @"tabbar_my_select"];
    
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    NewsViewController *newsVc = [[NewsViewController alloc] init];
    FindViewController *findVc = [[FindViewController alloc] init];
    MeViewController   *meVc   = [[MeViewController alloc] init];
    
    NSArray *viewControllers = @[homeVc,newsVc,findVc,meVc];
    for (int index = 0; index < viewControllers.count; index ++) {
        UIViewController *childVc = viewControllers[index];
        [self SetUpChildVc:childVc titles:titles[index] images:images[index] selectedImages:selectedImages[index]];
    }
    
}

//创建tabBar
- (void)SetUpChildVc:(UIViewController *)childVc titles:(NSString *)title images:(NSString *)imageName selectedImages:(NSString *)selecedImageName{
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selecedImageName];
    childVc.tabBarItem.title = title;
    nav.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}

#pragma mark - MianTabBarDelegate
- (void)tabBar:(MainTabBar *)tabBar didSelectButtonFrom:(long)fromBtnTag to:(long)toBtnTag{
    self.selectedIndex = toBtnTag;
}

- (void)tabBarCliclMiddleButton:(MainTabBar *)tabBar{
//    SubscriptionViewController *SubVC = [[SubscriptionViewController alloc] init];
//    [self presentViewController:SubVC animated:YES completion:nil];
    
//    //有导航栏的跳转
//    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:writeVc];
//    [self presentViewController:nav animated:YES completion:nil];
    NSArray *imgNameArray = @[@"0"
                              ,@"1"
                              ,@"2"
                              ,@"3"
                              ,@"4"
                              ,@"5",@"6",@"7"];
    NSArray *titleArray = @[@"相机"
                            ,@"朋友"
                            ,@"消息"
                            ,@"音乐"
                            ,@"相机"
                            ,@"更多",@"相机",@"相机"];
    self.subView = [[SubView alloc] initWithImageArr:imgNameArray titleArray:titleArray];
    self.subView.lineItmeNumber = 4;
    self.subView.itmeSize = CGSizeMake(100, 100);
    [self.subView addButtonItmeToAnimationView];
    [self.subView showAnimationView];
    [self.subView SetupCloseButton];
    __weak typeof(self) weakSelf = self;
    self.subView.SubItemBtnClickBlock = ^(NSInteger index){
        TestViewController *VC = [[TestViewController alloc] init];
        MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:VC];
//        [weakSelf presentViewController:nav animated:YES completion:nil];
    };
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
