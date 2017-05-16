//
//  MWLWaterLayout.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/15.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "MWLWaterLayout.h"

//默认的列数
static const NSInteger DefaultColumnCount = 2;
//默认的列间距
static const NSInteger DefaultColumnMargin = 10;
//默认的行间距
static const NSInteger DefaultRowMargin = 10;
//默认的边缘间距
static const UIEdgeInsets DefaultEdgeInsets = {10,10,10,10};

@interface MWLWaterLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;


@end


@implementation MWLWaterLayout

#pragma mark - 代理数据
- (CGFloat)rowMargin{
    if ([self.delagate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
       return  [self .delagate rowMarginInWaterflowLayout:self];
    }else{
        return DefaultRowMargin;
    }
}

- (CGFloat)columnMargin{
    if ([self.delagate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return  [self .delagate columnMarginInWaterflowLayout:self];
    }else{
        return DefaultColumnMargin;
    }
}

- (CGFloat)columnCount{
    if ([self.delagate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delagate columnCountInWaterflowLayout:self];
    }else{
        return DefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets{
    if ([self.delagate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return  [self .delagate edgeInsetsInWaterflowLayout:self];
    }else{
        return DefaultEdgeInsets;
    }
}
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
#pragma mark - 初始化数据
- (void)prepareLayout{
    [super prepareLayout];
    
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        //重新布局时，给出默认高度
        [self.columnHeights addObject:@(DefaultEdgeInsets.top)];
    }
    
    //清除之前的所有布局属性
    [self.attrsArray removeAllObjects];
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置cell对应的布局
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
        
    }
}

/** 
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}


/**
 * 返回indexPath位置cell对应的布局属性
 */

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建布局的属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionView 的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    //设置布局属性的frame
    CGFloat Width = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat Height = [self.delagate waterLayout:self itemWidth:Width indexPath:indexPath];
    
    //找出高度最短的哪一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        //取得i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat X = self.edgeInsets.left + destColumn * (Width + self.columnMargin);
    CGFloat Y = minColumnHeight;
    if (Y != self.edgeInsets.top) {
        Y += self.rowMargin;
    }
    attrs.frame = CGRectMake(X, Y, Width, Height);
    
    //跟新最短那列的高度(然后调此方法会重新计算)
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    //记录内容的高度
    CGFloat columnHeigth = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeigth) {
        self.contentHeight = columnHeigth;
    }
    
    return attrs;

}
- (CGSize)collectionViewContentSize
{
    
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

/**
 UICollectionViewLayoutAttributes
 
 //配置item的布局位置
 @property (nonatomic) CGRect frame;
 //配置item的中心
 @property (nonatomic) CGPoint center;
 //配置item的尺寸
 @property (nonatomic) CGSize size;
 //配置item的3D效果
 @property (nonatomic) CATransform3D transform3D;
 //配置item的bounds
 @property (nonatomic) CGRect bounds NS_AVAILABLE_IOS(7_0);
 //配置item的旋转
 @property (nonatomic) CGAffineTransform transform NS_AVAILABLE_IOS(7_0);
 //配置item的alpha
 @property (nonatomic) CGFloat alpha;
 //配置item的z坐标
 @property (nonatomic) NSInteger zIndex; // default is 0
 //配置item的隐藏
 @property (nonatomic, getter=isHidden) BOOL hidden;
 //item的indexpath
 @property (nonatomic, strong) NSIndexPath *indexPath;
 //获取item的类型
 @property (nonatomic, readonly) UICollectionElementCategory representedElementCategory;
 @property (nonatomic, readonly, nullable) NSString *representedElementKind;
 
 //一些创建方法
 + (instancetype)layoutAttributesForCellWithIndexPath:(NSIndexPath *)indexPath;
 + (instancetype)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind withIndexPath:(NSIndexPath *)indexPath;
 + (instancetype)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(NSIndexPath *)indexPath;
 */

@end
