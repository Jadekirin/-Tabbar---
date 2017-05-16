//
//  FriendLineCellModel.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/10.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FriendLineCellLikeItemModel,FriendLineCellCommentItemModel;
@interface FriendLineCellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *picNamesArray;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<FriendLineCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<FriendLineCellCommentItemModel *> *commentItemsArray;
@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;


@end

@interface FriendLineCellLikeItemModel : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSAttributedString *attributedContent;
@end


@interface FriendLineCellCommentItemModel: NSObject


@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end
