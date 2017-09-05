//
//  XMLockSudoko.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/9.
//  Copyright © 2017年 maweilong. All rights reserved.

/**  Description: 解锁九宫格*/

#import <UIKit/UIKit.h>
@class XMLockSudoko;
@protocol XMLockSudokoDelegate <NSObject>

- (void)sudoko:(XMLockSudoko *)sudoko passcodeDidCreate:(NSString *)passcode;

@end

@interface XMLockSudoko : UIView

@property (nonatomic,weak) id <XMLockSudokoDelegate> delegate;
- (instancetype)init;
- (void)showErrorPasscode:(NSString *)errorPasscode;
- (void)reset;

@end
