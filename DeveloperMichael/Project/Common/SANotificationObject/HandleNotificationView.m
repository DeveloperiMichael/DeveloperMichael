//
//  HandleNotificationView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "HandleNotificationView.h"
#import "Masonry.h"

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kNotificationManager [NotificationManager sharedInstance]

static CGFloat const kAnimationDuration = 0.2;
static CGFloat const kNotificationViewLeftSpace = 15.0;
static CGFloat const kNotificationWindowHeight = 81.0;
static CGFloat const kNotificationHidenDuration = 6.0;
static CGFloat const kTopHUDTypeNotiViewHeight = 45.0;
static CGFloat const kTopHUDTypeHidenDuration = 2.0;

typedef NS_ENUM(NSInteger, NotificationViewAnimationDirection) {
    NotificationViewAnimationToTop,
    NotificationViewAnimationToRight
};


@interface HandleNotificationView () <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isAnimation;
@property (nonatomic, assign) NotificationViewType type;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *item;
@property (nonatomic, copy) void(^didTapBlock)();
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) NotificationViewAnimationDirection animationDirection;

@property (nonatomic, assign) CGFloat notificationViewLeftSpace;
@property (nonatomic, assign) CGFloat contentViewTopSpace;
@property (nonatomic, assign) CGFloat contentViewHeight;
@property (nonatomic, assign) CGFloat notificationViewHeight;

@end


@interface NotificationManager () {
    CGFloat _rotationAngle;
}

@property (nonatomic, strong, readwrite) NSMutableArray <HandleNotificationView *>*notificationViewList;
@property (nonatomic, strong) UIWindow *notificationWindow;
@property (nonatomic, copy) void(^didAutoHideWindowBlock)();
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat notificationWindowHeight;
@property (nonatomic, assign) CGFloat notificationHidenDuration;

- (void)invalidateTimer;

@end

@implementation NotificationManager

+ (instancetype)sharedInstance {
    static NotificationManager *notificationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationManager = [[NotificationManager alloc] init];
        notificationManager.notificationHidenDuration = kNotificationHidenDuration;
    });
    return notificationManager;
}

- (NSMutableArray *)notificationViewList {
    if (!_notificationViewList) {
        _notificationViewList = [NSMutableArray array];
    }
    return _notificationViewList;
}

- (UIWindow *)notificationWindow {
    if (!_notificationWindow) {
        _notificationWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNotificationWindowHeight)];
        _notificationWindow.backgroundColor = [UIColor clearColor];
        _notificationWindow.windowLevel = UIWindowLevelAlert+1;
    }
    return _notificationWindow;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.notificationHidenDuration target:self selector:@selector(autoHide) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)autoHide {
    [self invalidateTimer];
    if (self.didAutoHideWindowBlock) {
        self.didAutoHideWindowBlock();
    }
}

- (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)resetWindowRotationTransformStateAndNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    kNotificationManager.notificationWindow.transform = [self getTransformRotationTransform];
    kNotificationManager.notificationWindow.frame = [self getWindowRotationTransformRect];
    
}

-(void)statusBarOrientationChange:(NSNotification *)notification {
    
    // 获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    if (currentOrientation == UIInterfaceOrientationPortrait) {
        
        [self toOrientation:UIInterfaceOrientationPortrait];
    } else {
        if (currentOrientation == UIInterfaceOrientationLandscapeRight) {
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        } else if (currentOrientation == UIInterfaceOrientationLandscapeLeft){
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        }
        
    }
    
}

- (void)toOrientation:(UIInterfaceOrientation)orientation {
    
    NSTimeInterval duration = 0.3;
    CGFloat angle = [self getRotationAngle];
    if (angle - _rotationAngle == M_PI||angle - _rotationAngle == -M_PI) {
        duration = 0.6;
    }
    
    HandleNotificationView *notificationView = [kNotificationManager.notificationWindow.subviews firstObject];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    // 获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    // 给你的播放视频的view视图设置旋转
    [UIView setAnimationDuration:duration];
    //    kNotificationManager.notificationWindow.transform = CGAffineTransformIdentity;
    kNotificationManager.notificationWindow.transform = [self getTransformRotationTransform];
    kNotificationManager.notificationWindow.frame = [self getWindowRotationTransformRect];
    notificationView.frame = CGRectMake(notificationView.notificationViewLeftSpace, 0, [UIScreen mainScreen].bounds.size.width-2*notificationView.notificationViewLeftSpace, kNotificationManager.notificationWindowHeight);
    
    // 开始旋转
    [UIView commitAnimations];
    [kNotificationManager.notificationWindow layoutIfNeeded];
}

/**
 * 获取变换的旋转角度
 *
 * @return 角度
 */
- (CGAffineTransform)getTransformRotationTransform
{
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        _rotationAngle = 0;
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        _rotationAngle = -M_PI_2;
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        _rotationAngle = M_PI_2;
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    _rotationAngle = 0;
    return CGAffineTransformIdentity;
}

- (CGFloat)getRotationAngle
{
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        
        return 0;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        
        return -M_PI_2;
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        
        return M_PI_2;
    }
    
    return 0;
}

- (CGRect)getWindowRotationTransformRect {
    
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        
        CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), self.notificationWindowHeight);
        return rect;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        
        CGRect rect = kNotificationManager.notificationWindow.frame;
        rect.origin = CGPointMake(0, 0);
        rect.size = CGSizeMake(self.notificationWindowHeight, CGRectGetWidth([UIScreen mainScreen].bounds));
        
        return rect;
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        
        CGRect rect = kNotificationManager.notificationWindow.frame;
        rect.origin = CGPointMake(CGRectGetHeight([UIScreen mainScreen].bounds)-self.notificationWindowHeight, 0);
        rect.size = CGSizeMake(self.notificationWindowHeight, CGRectGetWidth([UIScreen mainScreen].bounds));
        
        return rect;
    }
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), self.notificationWindowHeight);
    return rect;
}




@end

@implementation HandleNotificationView

- (instancetype)initWithFrame:(CGRect)frame type:(NotificationViewType)type{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        kNotificationManager.notificationHidenDuration = kNotificationHidenDuration;
        _notificationViewLeftSpace = kNotificationViewLeftSpace;
        _contentViewTopSpace = 6.0;
        _contentViewHeight = 75.0;
        
        [self setupSubViewsWithType:type];
        
    }
    return self;
}

- (void)setupSubViewsWithType:(NotificationViewType)type {
    
    _isAnimation = NO;
    _animationDirection = NotificationViewAnimationToTop;
    
    [self.contentView addSubview:self.contentLabel];
    [self addSubview:self.contentView];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.contentView addGestureRecognizer:_tap];
    
    self.type = type;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_contentViewTopSpace);
        make.bottom.mas_equalTo(0);
    }];
    
}

+ (void)showTopNormalHUDWithContent:(NSString *)content {
    
    [HandleNotificationView showNotificationViewWithContent:content type:NotificationViewTypeTopHUDNormal didClick:nil];
}

+ (void)showTopWarningHUDWithContent:(NSString *)content {
    
    [HandleNotificationView showNotificationViewWithContent:content type:NotificationViewTypeTopHUDWarning didClick:nil];
}

+ (void)showNotificationViewWithContent:(NSString *)content type:(NotificationViewType)type didClick:(void (^)())didClick{
    
    [HandleNotificationView removeLastNotificationView];
    
    HandleNotificationView *notificationView = [[HandleNotificationView alloc] initWithFrame:CGRectZero type:type];
    notificationView.contentLabel.text = content;
    notificationView.delegate = notificationView;
    notificationView.didTapBlock = didClick;
    notificationView.alwaysBounceVertical = YES;
    notificationView.clipsToBounds = NO;
    
    [kNotificationManager resetWindowRotationTransformStateAndNotify];
    [kNotificationManager.notificationWindow makeKeyAndVisible];
    [kNotificationManager.notificationWindow addSubview:notificationView];
    
    notificationView.frame = CGRectMake(notificationView.notificationViewLeftSpace, -kNotificationManager.notificationWindowHeight, [UIScreen mainScreen].bounds.size.width-2*notificationView.notificationViewLeftSpace, kNotificationManager.notificationWindowHeight);
    
    [notificationView addToNotificationViewManager];
    
    [notificationView animationToShow];
    
    __weak __typeof (notificationView)weakView = notificationView;
    [kNotificationManager setDidAutoHideWindowBlock:^{
        
        [weakView hide:YES];
    }];
    
}

- (void)addToNotificationViewManager {
    
    [kNotificationManager.notificationViewList addObject:self];
}

+ (void)removeLastNotificationView {
    
    HandleNotificationView *notificationView = [kNotificationManager.notificationViewList lastObject];
    [notificationView removeFromSuperview];
    notificationView.hidden = YES;
    [kNotificationManager.notificationViewList removeObject:notificationView];
    notificationView = nil;
    [kNotificationManager invalidateTimer];
    
}


#pragma mark-
#pragma mark-   NotificationViewShowAndHide
- (void)animationToShow {
    
    _isAnimation = YES;
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.frame = CGRectMake(self.notificationViewLeftSpace, 0, [UIScreen mainScreen].bounds.size.width-2*self.notificationViewLeftSpace, kNotificationManager.notificationWindowHeight);
        
    } completion:^(BOOL finished) {
        _isAnimation = NO;
        if (finished) {
            [kNotificationManager.timer timeInterval];
        }
        
    }];
}

+ (void)hide:(BOOL)animate {
    HandleNotificationView *notificationView = [kNotificationManager.notificationViewList firstObject];
    if (notificationView) {
        [notificationView hide:animate];
    }
}

- (void)hide:(BOOL)animate {
    
    
    CGFloat duration = animate?kAnimationDuration:0;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                if (_animationDirection == NotificationViewAnimationToTop) {
            self.frame = CGRectMake(self.notificationViewLeftSpace, -kNotificationManager.notificationWindowHeight, [UIScreen mainScreen].bounds.size.width-2*self.notificationViewLeftSpace, kNotificationManager.notificationWindowHeight);
        }else{
            self.frame = CGRectMake(self.notificationViewLeftSpace+[UIScreen mainScreen].bounds.size.width-2*self.notificationViewLeftSpace, 0, [UIScreen mainScreen].bounds.size.width-2*self.notificationViewLeftSpace, kNotificationManager.notificationWindowHeight);
        }
        
    } completion:^(BOOL finished) {
        _isAnimation = NO;
        if (finished) {
            [HandleNotificationView removeLastNotificationView];
            [kNotificationManager.notificationWindow removeFromSuperview];
            kNotificationManager.notificationWindow.hidden = YES;
            kNotificationManager.notificationWindow = nil;
        }
    }];
}

#pragma mark-
#pragma mark-   action method
- (void)didTap:(UITapGestureRecognizer *)tap {
    
    if (_isAnimation) return;
    _animationDirection = NotificationViewAnimationToRight;
    [self hide:YES];
    if (self.didTapBlock) {
        self.didTapBlock();
    }
}

- (void)didClickItem:(UIButton *)item {
    
    if (_isAnimation) return;
    _animationDirection = NotificationViewAnimationToRight;
    [self hide:YES];
    if (self.didTapBlock) {
        self.didTapBlock();
    }
}


#pragma mark-
#pragma mark-   UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.contentOffset.y > 10) {
        [self hide:YES];
    }
}


#pragma mark-
#pragma mark-   setter and getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.layer.cornerRadius = 6;
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor colorWithRed:91.0/255.0 green:95.0/255.0 blue:101.0/255.0 alpha:0.95];
    }
    return _contentView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 2;
        _contentLabel.font = [UIFont systemFontOfSize:16];
    }
    return _contentLabel;
}

- (UIButton *)item {
    
    if (!_item) {
        _item = [UIButton buttonWithType:UIButtonTypeCustom];
        [_item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _item.titleLabel.font = [UIFont systemFontOfSize:16];
        [_item addTarget:self action:@selector(didClickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _item;
}

//contentView 界面布局
- (void)setType:(NotificationViewType)type {
    _type = type;
    switch (type) {
        case NotificationViewTypeLocalNotification:{
            
            self.notificationViewHeight = kNotificationWindowHeight;
            kNotificationManager.notificationWindowHeight = kNotificationWindowHeight;
            
            [self.contentView addSubview:self.item];
            [self.item setImage:[UIImage imageNamed:@"icon_prompt_noti"] forState:UIControlStateNormal];
            
            [self.item mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.leading.mas_equalTo(kNotificationViewLeftSpace);
                make.centerY.mas_equalTo(0);
                make.height.mas_equalTo(28);
                make.width.mas_equalTo(28);
            }];
            
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.leading.equalTo(self.item.mas_trailing).offset(kNotificationViewLeftSpace);
                make.centerY.mas_equalTo(0);
                make.trailing.mas_equalTo(-kNotificationViewLeftSpace);
                
            }];
            
        }
            break;
        case NotificationViewTypeScreenShots:{
            
            self.notificationViewHeight = kNotificationWindowHeight;
            kNotificationManager.notificationWindowHeight = kNotificationWindowHeight;
            
            [self.contentView addSubview:self.item];
            self.tap.enabled = NO;
            self.contentLabel.text = NSLocalizedString(@"已截屏，是要吐槽么？", nil);
            [self.item setTitle:NSLocalizedString(@"吐槽", nil) forState:UIControlStateNormal];
            [self.item setBackgroundImage:[UIImage imageNamed:@"btn_bg"] forState:UIControlStateNormal];
            [self.item setBackgroundImage:[UIImage imageNamed:@"btn_bgCur"] forState:UIControlStateHighlighted];
            
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.leading.mas_equalTo(25);
                make.centerY.mas_equalTo(0);
                make.height.mas_equalTo(16);
            }];
            
            [self.item mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(0);
                make.trailing.mas_equalTo(-21);
                make.width.mas_equalTo(60);
                make.height.mas_equalTo(30);
            }];
        }
            break;
        default:{
            
            kNotificationManager.notificationHidenDuration = kTopHUDTypeHidenDuration;
            kNotificationManager.notificationWindowHeight = kTopHUDTypeNotiViewHeight;
            self.notificationViewHeight = kTopHUDTypeNotiViewHeight;
            self.contentViewHeight = kTopHUDTypeNotiViewHeight;
            self.notificationViewLeftSpace = 0;
            self.contentViewTopSpace = 0;
            self.contentView.layer.cornerRadius = 0;
            self.contentView.clipsToBounds = YES;
            
            if (type == NotificationViewTypeTopHUDNormal){
                self.contentView.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:187.0/255.0 blue:128.0/255.0 alpha:1.0];
            }else{
                self.contentView.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0];
            }
            self.tap.enabled = NO;
            
            self.contentLabel.font = [UIFont systemFontOfSize:13];
            self.contentLabel.numberOfLines = 2;
            self.contentLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
                make.leading.mas_equalTo(0);
                make.top.mas_equalTo(0);
            }];
        }
            break;
    }
    kNotificationManager.notificationWindow.frame = CGRectMake(0, 0, kScreenWidth, self.notificationViewHeight);
}


@end
