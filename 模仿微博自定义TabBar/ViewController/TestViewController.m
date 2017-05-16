//
//  TestViewController.m
//  模仿简书自定义Tabbar（纯代码）
//
//  Created by 余钦 on 16/5/30.
//  Copyright © 2016年 yuqin. All rights reserved.
//

#import "TestViewController.h"
#import "AnimationLayer.h"
#import "LabelSubView.h"
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
@interface TestViewController ()


@property (nonatomic,strong) LabelSubView *LabelSuperView;

@end

@implementation TestViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"'TestView";
    self.view.backgroundColor = [UIColor colorWithRed:22.0f/255.0 green:22.0f/255.0 blue:22.0f/255.0 alpha:1.0];
    [self SetupSnow];

    UIButton *closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closebtn setTitle:@"关闭" forState:UIControlStateNormal];
    closebtn.frame = CGRectMake(10, 10, 40, 25);
    [closebtn addTarget:self action:@selector(ClickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closebtn];
}

- (void)ClickCloseBtn{
    [self.LabelSuperView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (id layer in self.view.layer.sublayers) {
        if ([layer isKindOfClass:[AnimationLayer class]]) {
            [layer removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self SetupFireworks];
        [AnimationLayer createAnimationLayerWithString:@"姣姣宝贝，我爱你！" andRect:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width) andView:self.view andFont:[UIFont boldSystemFontOfSize:40] andStrokeColor:[UIColor cyanColor]];
    } completion:^(BOOL finished) {
        self.LabelSuperView = [[LabelSubView alloc] initWithStr:@"dcac"];
        [self.LabelSuperView SetUplabelWithRightLabel:@"我牵尔玉手收你此生所有;" LeftLabel:@"我抚尔秀颈挡你此生风雨。"];
        [self.LabelSuperView showLabel];
    }];
    
    
}

- (void)SetupSnow{
    //雪花❄️❄️❄️❄️/   /   /   //  /   //  //  //  //  //  /   //  /   /
    //   ////    /
    //CAEmitterLayer  粒子框架
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射位置
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width/2.0, -30);
    //发射源的尺寸大
    snowEmitter.emitterSize     = CGSizeMake(self.view.bounds.size.width *2.0, 0.0);
    //发射模式
    snowEmitter.emitterMode     = kCAEmitterLayerOutline;
    //发射源的形状
    snowEmitter.emitterShape    = kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    //随机颗粒的大小
    
    snowflake.scale         = 0.2;//缩放比例
    snowflake.scaleRange    = 0.5;//缩放比例范围
//    snowflake.scaleSpeed    = 0.1;//缩放比例速度
    snowflake.birthRate     = 20.0;//粒子参数的速度乘数因子
    snowflake.lifetime      = 60.0;//粒子的生命周期
    snowflake.velocity      = 20;//粒子的速度 falling down
    snowflake.velocityRange = 10;//速度范围
    snowflake.yAcceleration = 2;//粒子y方向的加速度分量
    snowflake.emissionRange = 0.5 * M_PI;// 周围发射角度   some variation in angle
    snowflake.spinRange     = 0.25 * M_PI;// 子旋转角度范围
    //是个CGImageRef的对象,既粒子要展现的图片
    snowflake.contents = (id)[[UIImage imageNamed:@"fire"] CGImage];
    //颜色
    snowflake.color    = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    snowEmitter.shadowOpacity   = 1.0;
    snowEmitter.shadowRadius    = 0.0;
    snowEmitter.shadowOffset    = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowColor     = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer addSublayer:snowEmitter];
    
    
}

- (void)SetupFireworks{
    //烟花背景
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    fireworksEmitter.emitterSize	= CGSizeMake(1, 0.0);
    fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    //fireworksEmitter.seed = 500;//(arc4random()%100)+300;
    
    CAEmitterCell *rocket = [CAEmitterCell emitterCell];
    rocket.birthRate		= 6.0;
    rocket.emissionRange	= 0.12 * M_PI;  // some variation in angle
    rocket.velocity			= 500;
    rocket.velocityRange	= 150;
    rocket.yAcceleration	= 0;
    rocket.lifetime			= 2.02;	// we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents			= (id) [[UIImage imageNamed:@"ball"] CGImage];
    rocket.scale			= 0.2;
    //    rocket.color			= [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
    rocket.greenRange		= 1.0;// different colors 一个粒子的颜色green 能改变的范围
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    
    rocket.spinRange		= M_PI;		// slow spin
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    //粒子爆发
    CAEmitterCell *burst = [CAEmitterCell emitterCell];
    burst.birthRate      = 1.0;// at the end of travel
    burst.velocity       = 0;
    burst.scale          = 2.5;
    burst.redSpeed       = -1.5;//shifting 移位
    burst.blueSpeed      = +1.5;
    burst.greenRange     = +1.0;
    burst.lifetime       = 0.35;
    
    // and finally, the sparks(火花)
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    spark.birthRate      = 666;
    spark.velocity       = 125;
    spark.emissionRange  = 2 * M_PI;//周围发射角度
    spark.yAcceleration  = 75;// 粒子y方向的加速度分量  gravity 重力
    spark.lifetime       = 3;
    spark.contents       = (id)[[UIImage imageNamed:@"fire"] CGImage];
    spark.scale          = 0.5;
    spark.scaleSpeed     = -0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.5;
    spark.spin				= 2* M_PI; //粒子旋转角度
    spark.spinRange			= 2* M_PI;
    
    //putting it together
    fireworksEmitter.emitterCells = [NSArray arrayWithObject:rocket];
    rocket.emitterCells           = [NSArray arrayWithObject:burst];
    burst.emitterCells            = [NSArray arrayWithObject:spark];
    
    [self.view.layer addSublayer:fireworksEmitter];
    
}






@end
