//
//  FriendLineCellModel.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/10.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FriendLineCellModel.h"

#import <UIKit/UIKit.h>

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@interface FriendLineCellModel ()


@end

@implementation FriendLineCellModel

{
    CGFloat _lastContentWidth;
}
@synthesize msgContent = _msgContent;


- (void)setMsgContent:(NSString *)msgContent
{
    
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msgContent ;
}




- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}


@end

@implementation FriendLineCellLikeItemModel



@end

@implementation FriendLineCellCommentItemModel



@end

