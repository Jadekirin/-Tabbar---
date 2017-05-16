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
#import "MainNavigationController.m"
#import "MainTabBar.h"

@interface MainTabBarController ()

@property (nonatomic, weak) MainTabBar *mainTabBar;


@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpMainTabBar];
    [self SetUpAllControllers];
}

- (void)SetUpMainTabBar{
    MainTabBar *mainTaBar = [[MainTabBar alloc] init];
    mainTaBar.frame = self.tabBar.bounds;//frame 等于系统tabBar的frame
    [self.view addSubview:mainTaBar];
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
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selecedImageName];
    childVc.tabBarItem.title = title;
    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    [self addChildViewController:nav];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
