//
//  CALayerProgressView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"
#import "LoadProgressView.h"
#import "CircleProgressView.h"
#import "WaveProgressView.h"
///UIView
@interface CALayerProgressView : BaseView

@property (nonatomic, strong) LoadProgressView *progressView;
@property (nonatomic, strong) CircleProgressView *circleProgress;
@property (nonatomic, strong) CircleProgressView *antiCircleProgress;
@property (nonatomic, strong) WaveProgressView *waveProgressView;
@property (nonatomic, strong) WaveProgressView *noWaveProgressView;

@end


