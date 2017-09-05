//
//  XMLockViewController.m
//  模仿微博自定义TabBar
//
//  Created by maweilong-PC on 2017/8/8.
//  Copyright © 2017年 maweilong. All rights reserved.
//

#import "XMLockViewController.h"
#import "XMLockConfig.h"
#import "Masonry.h"
#import "XMLockSudoko.h"
#import "XMLockTool.h"
#import "XMLockIndicator.h"
typedef NS_ENUM(NSInteger, XMLockStep) {
    XMLockStepNone = 0,
    XMLockStepCreateNew,
    XMLockStepCreateAgain,
    XMLockStepCreateNotMatch,//密码不相配 match 相配
    XMLockStepCreateReNew,//重置新密码
    XMLockStepModifyOld,//修改老密码 Modify  修改
    XMLockStepModifyOldError,
    XMLockStepModifyReOld,
    XMLockStepModifyNew,
    XMLockStepModifyAgain,
    XMLockStepModifyNotMatch,
    XMLockStepModifyReNew,//重新设置新密码
    XMLockStepVerifyOld,//Verify 验证
    XMLockStepVerifyOldError,
    XMLockStepVerifyReOld,
    XMLockStepRemoveOld,
    XMLockStepRemoveOldError,
    XMLockStepRemoveReOld
};

@interface XMLockViewController () <XMLockSudokoDelegate>
@property (nonatomic, assign) XMLockStep step;
@property (nonatomic, assign) XMLockType       type;
@property (nonatomic, strong) XMLockSudoko     *sudoko;
@property (nonatomic, strong) XMLockIndicator  *indicator;
@property (nonatomic, assign) XMLockAppearMode appearMode;
@property (nonatomic, strong) UIButton           *resetButton;//重置按钮
@property (nonatomic, strong) UILabel            *noticeLabel;
@property (nonatomic, strong) NSString           *passcodeTemp;//临时密码

@end

@implementation XMLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self createViews];
    
    switch (self.type) {
        case XMLockTypeCreate:
            [self updateViewForStep:XMLockStepCreateNew];
            break;
        case XMLockTypeModify:
            [self updateViewForStep:XMLockStepModifyOld];
            break;
        case XMLockTypeVerify:
            [self updateViewForStep:XMLockStepVerifyOld];
            break;
        case  XMLockTypeRemove:
            [self updateViewForStep:XMLockStepRemoveOld];
            break;
        default:
            break;
    }
}
#pragma mark - Init
- (instancetype)initWithDelegate:(id<XMLockViewControllerDelegate>)delegate type:(XMLockType)type appearMode:(XMLockAppearMode)appearMode{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.type = type;
        self.appearMode = appearMode;
    }
    return self;
}

- (void)setup{
    self.view.backgroundColor = XM_LOCK_COLOR_BACKGROUND;
    self.step = XMLockStepNone;
}

- (void)createViews{
    XMLockSudoko *sudoko = [[XMLockSudoko alloc] init];
    [self.view addSubview:sudoko];
    sudoko.delegate = self;
    [self setSudoko:sudoko];
    [sudoko mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kSudokoSideLength, kSudokoSideLength));
    }];
    
    //解锁指示器
    XMLockIndicator *indicator = [[XMLockIndicator alloc] init];
    [self.view addSubview:indicator];
    [self setIndicator:indicator];
    [indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(sudoko.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kIndicatorSideLength, kIndicatorSideLength));
    }];
    
    //提示Label
    UILabel *noticeLabel = [[UILabel alloc] init];
    [noticeLabel setFont:[UIFont systemFontOfSize:14]];
    [noticeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noticeLabel];
    [self setNoticeLabel:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(20);
    }];
    //重置按钮
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resetButton setTitle:XMLockResetText forState:UIControlStateNormal];
    [resetButton setTitleColor:XM_LOCK_COLOR_BUTTON forState:UIControlStateNormal];
    [resetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [resetButton addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    [self setResetButton:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(sudoko.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
}

#pragma  mark - XMLockSudokoDelegate
- (void)sudoko:(id)sudoko passcodeDidCreate:(NSString *)passcode{
    if ([passcode length] < kConnectionMinNum) {
        //密码长度不够情况
        [self.noticeLabel setText:XM_LOCK_NOT_ENOUGH];
        [self.noticeLabel setTextColor:XM_LOCK_COLOR_ERROR];
        [self shakeAnimationForView:self.noticeLabel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateViewForStep:self.step];
        });
        return;
    }
    switch (self.step) {
        case XMLockStepCreateNew:
        case XMLockStepCreateReNew:
            {
                self.passcodeTemp = passcode;
                [self updateViewForStep:XMLockStepCreateAgain];
                
                [self.indicator showPasscode:passcode];
            }
            break;
        case XMLockStepCreateAgain:
            if ([passcode isEqualToString:self.passcodeTemp]) {
                [XMLockTool setGestureUnlockEnabled:YES];
                [XMLockTool setGesturePasscode:passcode];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidCreate:)]) {
                    [self.delegate passcodeDidCreate:passcode];
                }
                [self hide];
            }else{
                [self updateViewForStep:XMLockStepCreateNotMatch];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel]; 
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateViewForStep:XMLockStepCreateReNew];
                });
            }
            break;
    //删除密码
        case XMLockStepRemoveOld:
        case XMLockStepRemoveReOld:
            if ([passcode isEqualToString:[XMLockTool currentGesturePasscode]])
            {
                [XMLockTool setGestureUnlockEnabled:NO];
                if ([self.delegate respondsToSelector:@selector(passcodeDidRemove)]) {
                    [self.delegate passcodeDidRemove];
                }
                [self hide];
            }else{
                [self updateViewForStep:XMLockStepRemoveOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateViewForStep:XMLockStepRemoveReOld];
                });
            }
            break;
        //验证旧密码
        case XMLockStepModifyOld:
        case XMLockStepModifyReOld:
            if ([passcode isEqualToString:[XMLockTool currentGesturePasscode]]) {
                //创建新密码
                [self updateViewForStep:XMLockStepModifyNew];
            }else{
                //重新输入旧密码
                [self updateViewForStep:XMLockStepModifyOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateViewForStep:XMLockStepModifyReOld];
                });
            }
            break;
        //设置新密码
        case XMLockStepModifyNew:
        case XMLockStepModifyReNew:
            self.passcodeTemp = passcode;
            [self updateViewForStep:XMLockStepModifyAgain];
            break;
        //再次确认新密码
        case XMLockStepModifyAgain:
            if ([passcode isEqualToString:self.passcodeTemp]) {
                [XMLockTool setGesturePasscode:passcode];
                
                if ([self.delegate respondsToSelector:@selector(passcodeDidModify:)]) {
                    [self.delegate passcodeDidModify:passcode];
                }
                [self hide];
            }else{
                [self updateViewForStep:XMLockStepModifyNotMatch];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateViewForStep:XMLockStepModifyReNew];
                });
            }
            break;
        //验证密码
        case XMLockStepVerifyOld:
        case XMLockStepVerifyReOld:
            if ([passcode isEqualToString:[XMLockTool currentGesturePasscode]]) {
                if ([self.delegate respondsToSelector:@selector(passcodeDidVerify:)]) {
                    [self.delegate passcodeDidVerify:passcode];
                }
                [self hide];
            }else{
                [self updateViewForStep:XMLockStepVerifyOldError];
                [self.sudoko showErrorPasscode:passcode];
                [self shakeAnimationForView:self.noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateViewForStep:XMLockStepVerifyReOld];
                });
            }
            break;
        default:
            break;
    }
    
    
}


#pragma mark - Private

- (void)updateViewForStep:(XMLockStep)step{
    self.step = step;
    switch (step) {
        case XMLockStepCreateNew:
            self.noticeLabel.text = XMLockNewText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
         case XMLockStepCreateAgain:
            self.noticeLabel.text = XMLockAgainText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = NO;
            self.indicator.hidden = NO;
            break;
        case XMLockStepCreateReNew:
            self.noticeLabel.text = XMLockReNewText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = NO;
            self.indicator.hidden = YES;
            break;
        case XMLockStepCreateNotMatch:
            self.noticeLabel.text = XMLockNotMatchText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_ERROR;
            self.resetButton.hidden = NO;
            self.indicator.hidden = YES;
            break;
        case XMLockStepRemoveOldError:
            self.noticeLabel.text = XMLockOldErrorText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_ERROR;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
        case XMLockStepRemoveOld:
            self.noticeLabel.text = XMLockOldText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
        case XMLockStepRemoveReOld:
            self.noticeLabel.text = XMLockReOldText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
        case XMLockStepModifyOld:
            self.noticeLabel.text = XMLockOldText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
        case XMLockStepModifyOldError:
            self.noticeLabel.text = XMLockOldErrorText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_ERROR;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
        case XMLockStepModifyReOld:
            self.noticeLabel.text = XMLockReOldText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
        case XMLockStepModifyNew:
            self.noticeLabel.text = XMLockNewText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = NO;
            self.indicator.hidden = YES;
            break;
        case XMLockStepModifyReNew:
            self.noticeLabel.text = XMLockReNewText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = NO;
            self.indicator.hidden = YES;
            break;
        case XMLockStepModifyAgain:
            self.noticeLabel.text = XMLockAgainText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = NO;
            self.indicator.hidden = NO;
            break;
        case XMLockStepVerifyOld:
            self.noticeLabel.text = XMLockVerifyText;
            self.noticeLabel.textColor = XM_LOCK_COLOR_NORMAL;
            self.resetButton.hidden = YES;
            self.indicator.hidden = YES;
            break;
        default:
            break;
    }
}

//T弹性动画
- (void)shakeAnimationForView:(UIView *)view{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}


#pragma mark - Action
- (void)hide{
    switch (self.appearMode) {
        case XMLockAppearModePush:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case XMLockAppearModePresent:
            [self dismissViewControllerAnimated:NO completion:nil];
            break;
        default:
            break;
    }
}

- (void)resetButtonClicked:(UIButton *)sender{
    if (self.type == XMLockTypeCreate) {
        [self updateViewForStep:XMLockStepCreateNew];
    }else if (self.type == XMLockTypeModify){
        [self updateViewForStep:XMLockStepModifyNew];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
