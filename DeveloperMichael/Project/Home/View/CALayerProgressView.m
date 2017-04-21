//
//  CALayerProgressView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CALayerProgressView.h"

static const CGFloat viewLength = 80;

@implementation CALayerProgressView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviewsContraints];
        
    }
    return self;
}

#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (LoadProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[LoadProgressView alloc] init];
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}

- (CircleProgressView *)circleProgress
{
    if(!_circleProgress)
    {
        _circleProgress = [[CircleProgressView alloc] init];
        _circleProgress.backgroundColor = [UIColor whiteColor];
        _circleProgress.layer.masksToBounds = YES;
        _circleProgress.centerLabel.text = @"0.00%";
        _circleProgress.layer.cornerRadius = viewLength*0.5;
    }
    return _circleProgress;
}

- (CircleProgressView *)antiCircleProgress
{
    if(!_antiCircleProgress)
    {
        _antiCircleProgress = [[CircleProgressView alloc] init];
        _antiCircleProgress.backgroundColor = [UIColor whiteColor];
        _antiCircleProgress.layer.masksToBounds = YES;
        _antiCircleProgress.centerLabel.text = @"跳过";
        _antiCircleProgress.clockwise = NO;
        _antiCircleProgress.layer.cornerRadius = viewLength*0.5;
    }
    return _antiCircleProgress;
}

- (WaveProgressView *)noWaveProgressView
{
    if(!_noWaveProgressView)
    {
        _noWaveProgressView  = [[WaveProgressView alloc] init];
        _noWaveProgressView.isShowWave = NO;
    }
    return _noWaveProgressView;
}

- (WaveProgressView *)waveProgressView
{
    if(!_waveProgressView)
    {
        _waveProgressView = [[WaveProgressView alloc] init];
    }
    return _waveProgressView;
}



#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.progressView];
    [self addSubview:self.circleProgress];
    [self addSubview:self.antiCircleProgress];
    [self addSubview:self.waveProgressView];
    [self addSubview:self.noWaveProgressView];
    [_antiCircleProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(-kScreenWidth()*0.25);
        make.top.mas_equalTo(self.navBarView.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(viewLength, viewLength));
    }];
    [_circleProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(kScreenWidth()*0.25);
        make.top.mas_equalTo(self.navBarView.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(viewLength, viewLength));
    }];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(-kScreenWidth()*0.25);
        make.top.mas_equalTo(self.antiCircleProgress.mas_bottom).mas_offset(40);
        make.size.mas_equalTo(CGSizeMake(viewLength, viewLength));
    }];
    [_noWaveProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(-kScreenWidth()*0.25);
        make.top.mas_equalTo(self.progressView.mas_bottom).mas_offset(40);
        make.size.mas_equalTo(CGSizeMake(viewLength, viewLength));
    }];
    [_waveProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(kScreenWidth()*0.25);
        make.top.mas_equalTo(self.progressView.mas_bottom).mas_offset(40);
        make.size.mas_equalTo(CGSizeMake(viewLength, viewLength));
    }];
    
}

@end





