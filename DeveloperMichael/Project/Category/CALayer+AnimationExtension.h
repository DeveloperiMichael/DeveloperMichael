//
//  CALayer+AnimationExtension.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/11.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (AnimationExtension)

/**
 视图中心为原点，左右抖动

 @param angle 抖动幅度
 @param count 抖动次数
 @param duration 动画时间
 */
- (void)shakeAroundLayerCenter:(CGFloat)angle
                   repeatCount:(NSInteger)count
             animationDuration:(CGFloat)duration;



/**
 弹一下

 @param fromValue 开始scale
 @param toValue 结束scale
 */
- (void)transformScaleBasicAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;



/**
 弹簧效果

 @param fromValue 开始scale
 @param toValue 结束scale
 */
- (void)transformScaleSpringAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;



@end
