//
//  CALayer+AnimationExtension.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/11.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CALayer+AnimationExtension.h"

@implementation CALayer (AnimationExtension)

- (void)shakeAroundLayerCenter:(CGFloat)angle
                   repeatCount:(NSInteger)count
             animationDuration:(CGFloat)duration{
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    keyAnima.keyPath=@"transform.rotation";
    keyAnima.duration=duration;
    //设置图标抖动弧度
    keyAnima.values=@[@(-angle),@(angle),@(-angle)];
    keyAnima.repeatCount=count;
    keyAnima.fillMode=kCAFillModeForwards;
    keyAnima.removedOnCompletion=NO;
    [self addAnimation:keyAnima forKey:@"shakeAroundLayerCenter"];
}


- (void)transformScaleBasicAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:fromValue];
    animation.toValue=[NSNumber numberWithFloat:toValue];
    animation.autoreverses=YES;
    animation.duration=0.15;
    animation.repeatCount=1;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [self addAnimation:animation forKey:@"basic.transform.scale"];
}

- (void)transformScaleSpringAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue{
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    //刚度系数越大，形变产生的力就越大，运动越快
    springAnimation.stiffness          = 5000;
    //质量越大，弹簧拉伸和压缩的幅度越大
    springAnimation.mass               = 10;
    //阻尼系数越大，停止越快
    springAnimation.damping            =100;
    //速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    springAnimation.initialVelocity    = 5.0;
    springAnimation.duration           = 0.25;
    //springAnimation.fromValue=[NSNumber numberWithFloat:fromValue];
    springAnimation.toValue=[NSNumber numberWithFloat:toValue];
    
    [self addAnimation:springAnimation forKey:@"spring.transform.scale"];
}

@end
