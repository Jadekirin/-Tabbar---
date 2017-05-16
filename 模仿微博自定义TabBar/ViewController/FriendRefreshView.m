//
//  FriendRefreshView.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/5/12.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "FriendRefreshView.h"
NSString *const RefreshViewObserveKeyPath = @"contentOffset";

@implementation FriendRefreshView

- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    [scrollView addObserver:self forKeyPath:RefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:RefreshViewObserveKeyPath];
    }
}

- (void)endRefrenshing{
    self.refrenshState = WXRefreshViewStateNormal;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}


@end
