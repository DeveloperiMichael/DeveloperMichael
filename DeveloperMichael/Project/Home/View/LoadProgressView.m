//
//  ProgressView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "LoadProgressView.h"

@interface LoadProgressView()


/**
 动画
 */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

/**
 上级视图
 */
@property (nonatomic, strong) UIView *selfSuperView;

/**
 禁止点击范围
 */
@property (nonatomic, strong) UIView *touchForbiddenView;

/**
 旋转圆视图
 */
@property (nonatomic, strong) UIView *animationView;

/**
 有text的旋转圆视图
 */
@property (nonatomic, strong) UIView *animationTextView;

/**
 提示信息
 */
@property (nonatomic, copy) NSString *alertString;

/**
 提示信息label
 */
@property (nonatomic, strong) UILabel *alertLabel;

/**
 default is 2
 */
@property (nonatomic, assign) CGFloat progressWidth;

/**
 default is graycolor
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 default is 1.0
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 旋转圆的直径，默认值36
 */
@property (nonatomic, assign) CGFloat diameterValue;



@end







@implementation LoadProgressView


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithShowInView:(UIView *)view withText:(NSString *)string{
    self = [super init];
    if (self) {
        self.selfSuperView = view;
        self.alertString = string;
        [self setupData];
        self.frame = CGRectMake(0, 0,  view.bounds.size.width,  view.bounds.size.height);
        [self addSubview:self.touchForbiddenView];
        
        if (self.alertString.length>0) {
            _diameterValue = 24;
            [self addSubview:self.animationTextView];
        }else{
            [self addSubview:self.animationView];
        }
        [self addNotificationObserver];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
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
    self.progressColor = [UIColor colorWithRed:255/255.0 green:164/255.0 blue:9/255.0 alpha:1.0];
    self.progressWidth = 2.0;
    self.diameterValue = 36.0;
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
    [self.animationView.layer addAnimation:rotationAni forKey:@"roration"];
    
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
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, _diameterValue, _diameterValue)];
    self.shapeLayer.path = path.CGPath;
    
    [self.shapeLayer addAnimation:group forKey:@"group"];
    [self.animationView.layer addSublayer:self.shapeLayer];
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

- (UIView *)touchForbiddenView {
    if (!_touchForbiddenView) {
        _touchForbiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,  self.bounds.size.height)];
    }
    return _touchForbiddenView;
}

- (UIView *)animationView {
    if (!_animationView) {
        if (_alertString.length>0) {
            _animationView = [[UIView alloc] initWithFrame:CGRectMake(20, (80-_diameterValue)*0.5, _diameterValue, _diameterValue)];
        }else{
            _animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _diameterValue,  _diameterValue)];
            _animationView.center = self.center;
        }
    }
    return _animationView;
}

- (UIView *)animationTextView {
    if (!_animationTextView) {
        _animationTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 256, 80)];
        _animationTextView.backgroundColor = [UIColor whiteColor];
        _animationTextView.layer.masksToBounds = YES;
        _animationTextView.layer.cornerRadius = 4;
        _animationTextView.layer.shadowColor = [UIColor grayColor].CGColor;
        _animationTextView.layer.shadowOpacity = 0.5;
        _animationTextView.layer.shadowOffset = CGSizeMake(0, 1);
        _animationTextView.center = self.center;
        [_animationTextView addSubview:self.animationView];
        [_animationTextView addSubview:self.alertLabel];
    }
    return _animationTextView;
}

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(_animationTextView.frame.size.width-20-_diameterValue-144, 0, 144, 80)];
        _alertLabel.text = _alertString;
        _alertLabel.numberOfLines = 0;
        _alertLabel.font = [UIFont systemFontOfSize:18.0];
        _alertLabel.textColor = [UIColor grayColor];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _alertLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
}



@end
