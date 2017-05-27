//
//  BaseView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()


@end

@implementation BaseView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response

- (void)leftButtonPressed:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(leftButtonClicked:)]) {
        [_delegate leftButtonClicked:self];
    }
}

- (void)rightButtonPressed:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(rightButtonClicked:)]) {
        [_delegate rightButtonClicked:self];
    }
}



#pragma mark-
#pragma mark- Private Methods





#pragma mark-
#pragma mark- Getters && Setters

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ads2"]];
    }
    return _bgImageView;
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc] init];
    }
    return _navBarView;
}

- (UIImageView *)navBarImageView {
    if (!_navBarImageView) {
        _navBarImageView = [[UIImageView alloc] init];
        _navBarImageView.backgroundColor = kColorByRGB(0, 0, 0, 0.2);
    }
    return _navBarImageView;
}

- (SAButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [SAButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_leftButton setTitle:@"Back" forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        _leftButton.locationType = ImageLocateLeftAndTotalLeft;
        [_leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (SAButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [SAButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_rightButton setTitle:@"Next" forState:UIControlStateNormal];
        _rightButton.locationType = ImageLocateRightAndTotalRight;
        [_rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.text = @"DeveloperMichael";
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupContraints{
    [self addSubview:self.bgImageView];
    [self addSubview:self.navBarView];
    [self.navBarView addSubview:self.navBarImageView];
    [self.navBarView addSubview:self.leftButton];
    [self.navBarView addSubview:self.titleLabel];
    [self.navBarView addSubview:self.rightButton];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(NavigationBarHeight()+StatusBarHeight());
    }];
    [_navBarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_navBarView);
    }];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_navBarView).mas_offset(7.5);
        make.top.mas_equalTo(StatusBarHeight());
        make.height.mas_equalTo(NavigationBarHeight());
        make.width.mas_equalTo(80);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_navBarView).mas_offset(-12);
        make.height.mas_equalTo(NavigationBarHeight());
        make.top.mas_equalTo(StatusBarHeight());
        make.width.mas_equalTo(60);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(NavigationBarHeight());
        make.top.mas_equalTo(StatusBarHeight());
        make.left.mas_equalTo(_leftButton.mas_right);
        make.right.mas_equalTo(_rightButton.mas_left);
    }];
}



@end
