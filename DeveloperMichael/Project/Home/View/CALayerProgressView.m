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
        _progressView.backgroundColor = kColorByRGB(255, 255, 255, 1);
    }
    return _progressView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(-kScreenWidth()*0.25);
        make.top.mas_equalTo(self.navBarView.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(viewLength, viewLength));
    }];
    
}

@end





