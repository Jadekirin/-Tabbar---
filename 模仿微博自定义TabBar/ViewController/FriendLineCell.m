//
//  FriendLineCell.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/10.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FriendLineCell.h"
#import "UIView+SDAutoLayout.h"
#import "PhotoContainerView.h"
#import "WXCommentView.h"
#define LineCellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]
CGFloat maxContentLabelHeight = 0; // 根据具体font而定
@interface FriendLineCell ()
{
    UIImageView *_iconView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;//内容
    UILabel *_timeLabel;
    UIButton *_moreButton;
    UIButton *_operationButton;//操作按钮
    PhotoContainerView *_photoContainerView;//图片View
    WXCommentView *_commentView;//评论view
    
}
@end

@implementation FriendLineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    _iconView = [UIImageView new];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14.0];
    _nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:15.0];
    _contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;//设置最多显示3行
    }
    
    //全文按钮
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:LineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];

    //图片View
    _photoContainerView = [[PhotoContainerView alloc] init];
    
    
    //评论按钮
    _operationButton = [UIButton new];
    [_operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
//    _picContainerView = [SDWeiXinPhotoContainerView new];
    
    _commentView = [WXCommentView new];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    
    NSArray *views = @[_iconView, _nameLabel, _contentLabel, _moreButton,_photoContainerView,  _timeLabel, _operationButton,];
    
    [self.contentView sd_addSubviews:views];
    
    //布局
    UIView *contentView = self.contentView;
    CGFloat margin = 10;//边缘
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView,margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    _photoContainerView.sd_layout
    .leftEqualToView(_contentLabel);// 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    _timeLabel.sd_layout
    .leftEqualToView(_photoContainerView)
    .topSpaceToView(_photoContainerView, margin)
    .heightIs(15);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _operationButton.sd_layout
    .rightSpaceToView(contentView, margin)
    .centerYEqualToView(_timeLabel)
    .heightIs(25)
    .widthIs(25);
    
    _commentView.sd_layout
    .leftEqualToView(contentView)
    .rightSpaceToView(self.contentView, margin)
    .topSpaceToView(_timeLabel, margin); // 已经在内部实现高度自适应所以不需要再设置高度
    
}


//填充数据
- (void)setModel:(FriendLineCellModel *)model{
    _model = model;
    
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLabel.text = model.name;
    _contentLabel.text = model.msgContent;
    _photoContainerView.picPathStringArray = model.picNamesArray;
    if (model.shouldShowMoreButton) {
        //如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) {
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        }else{
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    }else{
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _photoContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
//    UIView *bottomView;
//    if (model.likeItemsArray.count == 0 && model.commentItemsArray.count == 0) {
//        bottomView = _timeLabel;
//    }else{
//        bottomView = _commentView;
//    }
    
    //设置最底部的view   不可缺少
    [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:15];
    
    _timeLabel.text = @"一分钟前";
    
}


#pragma mark - button 点击事件

- (void)moreButtonClicked{
    //全文点击
    if (_moreButtonClickBlock) {
        _moreButtonClickBlock(self.indexPath);
    }
}

- (void)operationButtonClicked{
    //评论
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
