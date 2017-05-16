//
//  FriendLineCell.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/10.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendLineCellModel.h"
@interface FriendLineCell : UITableViewCell

@property (nonatomic,strong) FriendLineCellModel *model;


@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,copy) void (^moreButtonClickBlock) (NSIndexPath *indexPatn);

@end
