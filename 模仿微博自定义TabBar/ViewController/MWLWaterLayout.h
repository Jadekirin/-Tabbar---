//
//  MWLWaterLayout.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/15.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MWLWaterLayoutDelegate <NSObject>

@required


- (CGFloat)waterLayout:(UICollectionViewLayout *)waterLayout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  返回的列数
 */
- (CGFloat)columnCountInWaterflowLayout:(UICollectionViewLayout*)layout;

/**
 *  行间距
 */
- (CGFloat)rowMarginInWaterflowLayout:(UICollectionViewLayout*)layout;

/**
 *  列间距
 */
- (CGFloat)columnMarginInWaterflowLayout:(UICollectionViewLayout*)layout;
/**
 *  collectionView内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout*)layout;
@end

@interface MWLWaterLayout : UICollectionViewLayout

@property (nonatomic, weak) id<MWLWaterLayoutDelegate> delagate;

@end
