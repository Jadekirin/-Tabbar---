//
//  XMLockIndicator.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/22.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLockIndicator : UIView

- (instancetype)init;
- (void)showPasscode:(NSString *)passcode;
- (void)reset;

@end
