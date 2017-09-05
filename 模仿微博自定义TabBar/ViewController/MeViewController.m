//
//  MeViewController.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/5.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "MeViewController.h"

#import "Masonry.h"
#import "XMLockTool.h"
#import "LockSettingViewController.h"
#import "XMLockViewController.h"
@interface MeViewController ()<UITableViewDataSource, UITableViewDelegate,XMLockViewControllerDelegate>

@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    [self createTab];
    if ([XMLockTool isGestureUnlockEnabled]) {
        XMLockViewController *XMLock = [[XMLockViewController alloc] initWithDelegate:nil type:XMLockTypeVerify appearMode:XMLockAppearModePresent];
        
        [self presentViewController:XMLock animated:YES completion:nil];
    }
    
    
}

#pragma XMLockViewControllerDelegate
//- (void)passcodeDidVerify:(NSString *)passcode{
//    if ([passcode isEqualToString:[XMLockTool currentGesturePasscode]]) {
//        [self createTab];
//    }
//}

- (void)createTab{
    UITableView *settingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [settingTableView setShowsVerticalScrollIndicator:NO];
    [settingTableView setShowsHorizontalScrollIndicator:NO];
    [settingTableView setDataSource:self];
    [settingTableView setDelegate:self];
    [self.view addSubview:settingTableView];
    [settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idendifier = @"SettingTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idendifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idendifier];
    }
    
    cell.textLabel.text = @"应用加密";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        [self.navigationController pushViewController:[[LockSettingViewController alloc] init] animated:YES];
    }
}




@end
