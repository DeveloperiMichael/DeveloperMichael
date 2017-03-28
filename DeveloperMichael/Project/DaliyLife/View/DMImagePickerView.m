//
//  DMImagePickerView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/20.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMImagePickerView.h"

@interface DMImagePickerView()


@property (nonatomic, strong) UIView *bottomView;


@end

@implementation DMImagePickerView

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

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kColorByRGB(0, 0, 0, 0.2);
    }
    return _bottomView;
}

- (UIButton *)previewButton {
    if (!_previewButton) {
        _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previewButton setTitle:@"Preview" forState:UIControlStateNormal];
        [_previewButton setTitleColor:kColorByRGB(255, 255, 255, 0.3) forState:UIControlStateDisabled];
        [_previewButton setTitleColor:kColorByRGB(255, 255, 255, 1) forState:UIControlStateSelected];
        _previewButton.enabled = NO;
        _previewButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:17.0]];
        _previewButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _previewButton;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton setTitleColor:kColorByRGB(5, 181, 15, 0.5) forState:UIControlStateDisabled];
        [_doneButton setTitleColor:kColorByRGB(5, 181, 15, 1) forState:UIControlStateSelected];
        _doneButton.enabled = NO;
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:17.0]];
        _doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _doneButton;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:12.0]];
        _numberLabel.backgroundColor = kColorByRGB(1, 181, 15, 1);
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.hidden = YES;
        _numberLabel.layer.cornerRadius = kScreenHeightRatio(15)*0.5;
    }
    return _numberLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    self.titleLabel.text = @"Photo Select";
    [self.rightButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.previewButton];
    [self.bottomView addSubview:self.doneButton];
    [self.bottomView addSubview:self.numberLabel];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(kScreenHeightRatio(40));
    }];
    [_previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(7.5);
        make.top.bottom.mas_equalTo(_bottomView);
        make.width.mas_equalTo(kScreenWidthRatio(80));
    }];
    [_doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-7.5);
        make.top.bottom.mas_equalTo(_bottomView);
        make.width.mas_equalTo(kScreenWidthRatio(40));
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_doneButton.mas_left);
        make.centerY.mas_equalTo(_bottomView);
        make.height.mas_equalTo(kScreenHeightRatio(15));
        make.width.mas_equalTo(kScreenHeightRatio(15));
    }];
}


@end
