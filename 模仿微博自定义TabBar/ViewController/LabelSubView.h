//
//  LabelSubView.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/10.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelSubView : UIView
- (instancetype)initWithStr:(NSString*)str;
- (void)SetUplabelWithRightLabel:(NSString *)rightStr LeftLabel:(NSString *)leftStr;
- (void)showLabel;
@end
