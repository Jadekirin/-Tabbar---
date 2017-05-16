//
//  SubView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/9.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "SubView.h"
#import "SubButton.h"
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface SubView ()
//
//@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) UIButton *closeBtn;
@end

@implementation SubView
- (instancetype)initWithImageArr:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _imageNameArray = imageArray;
        _itemTitleArray = titleArray;
    }
    return self;
}

- (NSMutableArray *)ItemButtonArray{
    if (!_ItemButtonArray) {
        _ItemButtonArray = [NSMutableArray array];
    }
    return _ItemButtonArray;
}

#pragma mark ----- 循环创建按钮
- (void)addButtonItmeToAnimationView{
    // 按钮之间的间隔
    CGFloat space = (ScreenWidth - _lineItmeNumber * _itmeSize.width)/(_lineItmeNumber + 1);
    
    // 计算有多少行
    NSInteger muchLine = 0;
    
    if (_imageNameArray.count % _lineItmeNumber == 0 ) {
        muchLine = _imageNameArray.count / _lineItmeNumber;
    }
    else
    {
        muchLine = _imageNameArray.count / _lineItmeNumber + 1;
    }
    
    for (NSInteger index = 0; index < _imageNameArray.count ; index ++) {
        SubButton *button = [SubButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(space + (space + _itmeSize.width) * (index % _lineItmeNumber), ScreenHeight - muchLine * _itmeSize.height - 100 + (_itmeSize.height + 20) * (index/_lineItmeNumber) , _itmeSize.width, _itmeSize.height);
        [button setButtonBackgroungImage:[UIImage imageNamed:_imageNameArray[index]] WithTitle:_itemTitleArray[index] withTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ClickItemButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + index;
        [self addSubview:button];
        [self.ItemButtonArray addObject:button];
        
        //将按钮隐藏在底部
        button.transform = CGAffineTransformMakeTranslation(0, ScreenHeight);
    }
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark ----- 创建关闭按钮
- (void)SetupCloseButton{
    UIView *LineView = [[UIView alloc] initWithFrame:CGRectMake(0, (ScreenHeight - 61), ScreenWidth, 1)];
    LineView.backgroundColor = [UIColor grayColor];
    [self addSubview:LineView];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeBtn.frame = CGRectMake((ScreenWidth - 60)/2, (ScreenHeight - 60), 60, 60);
    [_closeBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
//    [closeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(CloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeBtn];
}


#pragma mark ----- 动画显示按钮
- (void)showAnimationView{
    for (NSInteger index = 0; index < _ItemButtonArray.count; index ++) {
        __block UIButton *btn = _ItemButtonArray[index];
        [UIView animateWithDuration:0.5 delay:index * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 还原位置
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
        
    }
}
#pragma mark ----- 动画关闭按钮
- (void)closeAnimationView{
    //翻转数据 倒序数组
    NSArray *flipButtonArray = [[_ItemButtonArray reverseObjectEnumerator] allObjects];
    for (NSInteger index = 0; index < flipButtonArray.count; index ++) {
        __block UIButton *btn = flipButtonArray[index];
        [UIView animateWithDuration:0.5 delay:index * 0.05 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 返回屏幕底部
            btn.transform = CGAffineTransformMakeTranslation(0, ScreenHeight);
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
        
    }
}

#pragma mark - 点击时间

//点击button
- (void)ClickItemButton:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_SubItemBtnClickBlock) {
            _SubItemBtnClickBlock(sender.tag - 100);
        }
        
    }];
}


//关闭按钮
- (void)CloseBtn{
    [UIView animateWithDuration:0.3 animations:^{
        
        //旋转45°
        self.closeBtn.transform = CGAffineTransformMakeRotation(-M_PI/4);
        
    } completion:^(BOOL finished) {
        [self closeAnimationView];
    }];
    
}

//赋值block
//- (void)ClickItemButtonBlock:(SubItemBtnClickBlock)block{
//    _block = block;
//}

@end
