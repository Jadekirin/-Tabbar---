//
//  XMLockCricle.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
/**
 *  Description: 画圆圈
 */

#import <UIKit/UIKit.h>
#import "XMLockConfig.h"
typedef NS_ENUM(NSInteger, XMLockCricleState){
    XMLockCircleStateNormal = 0,
    XMLockCircleStateSelected,
    XMLockCircleStateFill,
    XMLockCircleStateError
};

@interface XMLockCricle : UIView

@property (nonatomic,assign) XMLockCricleState state;
@property (nonatomic,assign) CGFloat diameter;

- (instancetype)initWithDiameter:(CGFloat)diameter;
- (void)UpdateCricleState:(XMLockCricleState)state;

@end
