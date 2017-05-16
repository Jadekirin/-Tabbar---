//
//  FriendRefreshView.h
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import <UIKit/UIKit.h>
// extern是C/C++语言中表明函数和全局变量作用范围（可见性）的关键字
UIKIT_EXTERN NSString *const kRefrenshViewObserveKeyPath;
typedef enum {
    WXRefreshViewStateNormal,
    WXRefreshViewStateWillRefresh,
    WXRefreshViewStateRefreshing,
} WXRefreshViewState;


@interface FriendRefreshView : UIView

@property (nonatomic ,strong) UIScrollView *scrollView;

- (void)endRefrenshing;

@property (nonatomic,assign) UIEdgeInsets scrollViewOriginalInsets;
@property (nonatomic,assign) WXRefreshViewState refrenshState;

@end
