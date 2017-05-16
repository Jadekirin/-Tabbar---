//
//  SubView.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/9.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SubItemBtnClickBlock)(NSInteger index);

@interface SubView : UIView

/**
 *  按钮大小
 */
@property (nonatomic,assign) CGSize itmeSize;
/**
 *  每行按钮数量
 */
@property (nonatomic,assign) NSInteger lineItmeNumber;
/**
 *  按钮图片名字
 */
@property (nonatomic,strong) NSArray *imageNameArray;
/**
 *  按钮title
 */
@property (nonatomic,strong) NSArray *itemTitleArray;
/**
 *  按钮字体大小
 */
@property (nonatomic,strong) UIFont *itmeTitleFont;
/**
 *  按钮数组
 */
@property (nonatomic,strong) NSMutableArray *ItemButtonArray;

@property (nonatomic,strong) void (^SubItemBtnClickBlock)(NSInteger index);

- (instancetype)initWithImageArr:(NSArray *)imageArray titleArray:(NSArray *)titleArray;
- (void)addButtonItmeToAnimationView;
- (void)showAnimationView;
- (void)SetupCloseButton;

//- (void)ClickItemButtonBlock:(SubItemBtnClickBlock)block;
@end
