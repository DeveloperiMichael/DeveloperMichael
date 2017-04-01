//
//  ProgressView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "LoadProgressView.h"
#import "BaseViewHeader.h"
#import "BaseViewHeader.h"

@interface LoadProgressView()

@property(nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation LoadProgressView


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupData];
        [self addNotificationObserver];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    [self setupLoadProgress];
}

#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

- (void)setupData {
    self.animationDuration = 1.0;
    self.progressColor = kColorByRGB(245, 30, 1, 1);
    self.progressWidth = 4.0;
}

- (void)setupLoadProgress {
    // 断言 当前面的表达式为假值时 打印后面的内容 但是程序还是会崩溃
    NSAssert(self.progressWidth > 0.0, @"进度条宽度必须大于0");
    
    [self.layer removeAllAnimations];
    [self addAnimation];
}

- (void)addAnimation
{
    // 绕z轴旋转 使每次重合的位置不同
    CABasicAnimation *rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.fromValue = @0.0;
    rotationAni.toValue = @(2 * M_PI);
    rotationAni.duration = 3;
    rotationAni.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAni forKey:@"roration"];
    
    // strokeEnd 正向画出路径
    CABasicAnimation *endAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAni.fromValue = @0.0;
    endAni.toValue = @1.0;
    endAni.duration = self.animationDuration;
    endAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // strokeStart 反向清除路径
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @0.0;
    startAni.toValue = @1.0;
    startAni.duration = self.animationDuration;
    startAni.beginTime = self.animationDuration;
    startAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[endAni, startAni];
    group.repeatCount = MAXFLOAT;
    group.fillMode = kCAFillModeForwards;
    group.duration = 2*self.animationDuration;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.view_width, self.view_height)];
    self.shapeLayer.path = path.CGPath;
    
    [self.shapeLayer addAnimation:group forKey:@"group"];
    [self.layer addSublayer:self.shapeLayer];
}


// 当程序重新进入前台或活跃状态，动画仍然会执行
- (void)addNotificationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark-
#pragma mark- Getters && Setters

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineWidth = self.progressWidth;
        _shapeLayer.strokeColor = self.progressColor.CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeStart = 0.0;
        _shapeLayer.strokeEnd = 1.0;
    }
    return _shapeLayer;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
}



@end
