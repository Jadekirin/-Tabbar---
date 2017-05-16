//
//  FindViewController.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/5.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FindViewController.h"
#import "FriendsViewController.h"
#import "CascadeFlowViewController.h"
@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
    
    _dataArray = @[@"朋友圈",@"瀑布流"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:self.tableView];
    
//    UIButton *Passbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Passbtn setTitle:@"跳转到朋友圈" forState:UIControlStateNormal];
//    Passbtn.frame = CGRectMake(100, 100, 240, 25);
//    [Passbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [Passbtn addTarget:self action:@selector(ClickPassBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:Passbtn];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FriendsViewController *vc = [[FriendsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        CascadeFlowViewController *vc = [[CascadeFlowViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)ClickPassBtn{
    FriendsViewController *vc = [[FriendsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
