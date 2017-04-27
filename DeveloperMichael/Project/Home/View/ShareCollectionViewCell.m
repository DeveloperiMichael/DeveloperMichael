//
//  ShareCollectionViewCell.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/27.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "ShareCollectionViewCell.h"
#import "BaseViewHeader.h"
@implementation ShareCollectionViewCell

#pragma mark-
#pragma mark- View Life Cycle

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubviewsContraints];
}
#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)platformLabel {
    if (!_platformLabel) {
        _platformLabel = [[UILabel alloc] init];
        _platformLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:13.0]];
        _platformLabel.textAlignment = NSTextAlignmentCenter;
        _platformLabel.textColor = kColorByRGB(93, 93, 93, 1);
    }
    return _platformLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.iconImage];
    [self addSubview:self.platformLabel];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(0);
        make.width.height.mas_equalTo(50);
    }];
    [_platformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-7.5);
        make.top.mas_equalTo(_iconImage.mas_bottom).offset(7.5);
    }];
}


@end
