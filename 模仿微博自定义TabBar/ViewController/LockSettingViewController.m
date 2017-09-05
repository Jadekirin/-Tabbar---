//
//  LockSettingViewController.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/7.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "LockSettingViewController.h"
#import "XMLockViewController.h"
#import "Masonry.h"
#import "XMLockTool.h"
@interface LockSettingViewController ()<UITableViewDelegate,UITableViewDataSource,XMLockViewControllerDelegate>
@property (nonatomic, strong) UITableView *lockSettingTableView;
@end

@implementation LockSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViews];
}

- (void)createViews{
    self.title = @"应用加密";
    
    self.lockSettingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.lockSettingTableView.delegate = self;
    self.lockSettingTableView.dataSource = self;
    [self.view addSubview:self.lockSettingTableView];
    [self.lockSettingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (![XMLockTool isGestureUnlockEnabled]) {
        return 1;
    }else{
        return 2;
    }
}
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
    
    if (indexPath.section == 0) {
        UISwitch *gestureLockSwitch = [[UISwitch alloc] init];
        [gestureLockSwitch setOn:[XMLockTool isGestureUnlockEnabled]];
        [gestureLockSwitch addTarget:self action:@selector(gestureLockSwitch:) forControlEvents:UIControlEventValueChanged];
        cell.textLabel.text = @"手势解锁";
        cell.accessoryView = gestureLockSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        cell.textLabel.text = @"修改手势密码";
    }
    
    
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 && indexPath.section == 1)
    {
        XMLockViewController * XMLockVC = [[XMLockViewController alloc] initWithDelegate:self type:XMLockTypeModify appearMode:XMLockAppearModePush];
        [self.navigationController pushViewController:XMLockVC animated:YES];
    }
}

//gestureLockSwitch 点击事件
- (void)gestureLockSwitch:(UISwitch*)sender{
    if (sender.on) {

        XMLockViewController * XMLockVC = [[XMLockViewController alloc] initWithDelegate:self type:XMLockTypeCreate appearMode:XMLockAppearModePush];
        [self.navigationController pushViewController:XMLockVC animated:YES];
    }else{
        XMLockViewController * XMLockVC = [[XMLockViewController alloc] initWithDelegate:self type:XMLockTypeRemove appearMode:XMLockAppearModePush];
        [self.navigationController pushViewController:XMLockVC animated:YES];
    }
    [self.lockSettingTableView reloadData];
}



#pragma mark - XMLockViewControllerDelegate
- (void)passcodeDidCreate:(NSString *)passcode{
    [self.lockSettingTableView reloadData];
}

- (void)passcodeDidRemove{
    [self.lockSettingTableView reloadData];
}

- (void)passcodeDidModify:(NSString *)passcode{
    [self.lockSettingTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
