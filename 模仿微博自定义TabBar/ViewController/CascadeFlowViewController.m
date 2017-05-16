//
//  CascadeFlowViewController.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "CascadeFlowViewController.h"
#import "FlowCell.h"
#import "MWLWaterLayout.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CascadeFlowViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MWLWaterLayoutDelegate>
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_flowLayout;
    
}
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CascadeFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"瀑布流";
    
    self.dataArray = [NSMutableArray new];
    for (int i=0; i<31; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"photo_%d",i]];
    }
    
    [self setupcollectionView];
}

- (void)setupcollectionView{
    MWLWaterLayout *layout = [[MWLWaterLayout alloc] init];
    layout.delagate = self;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight ) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[FlowCell class] forCellWithReuseIdentifier:@"FlowCell"];
    [self.view addSubview:_collectionView];
}


#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    [cell SetData:self.dataArray[indexPath.row]];
    
    return cell;
}



#pragma mark - MWLWagterDelegate
- (CGFloat)waterLayout:(UICollectionViewLayout *)waterLayout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    UIImage *image = [UIImage imageNamed:self.dataArray[indexPath.row]];
   // NSData *data = UIImagePNGRepresentation(image);
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    return itemWidth * (fixelH / fixelW);
}
- (CGFloat)columnCountInWaterflowLayout:(UICollectionViewLayout *)layout{
    //设置瀑布流的列数
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(UICollectionViewLayout *)layout{
    return 10;
}

- (CGFloat)columnMarginInWaterflowLayout:(UICollectionViewLayout *)layout{
    return 10;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout *)layout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
