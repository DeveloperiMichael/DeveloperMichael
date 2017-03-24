//
//  CABasicAnimationView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CABasicAnimationView.h"

@interface CABasicAnimationView()

@end

@implementation CABasicAnimationView

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

- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [[UIView alloc] init];
        _animationView.backgroundColor = kColorByRGB(237, 116, 128, 1);
    }
    return _animationView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.animationView];
    [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(72);
        make.width.mas_equalTo(kScreenWidthRatio(100));
        make.height.mas_equalTo(kScreenHeightRatio(100));
    }];
}


@end
