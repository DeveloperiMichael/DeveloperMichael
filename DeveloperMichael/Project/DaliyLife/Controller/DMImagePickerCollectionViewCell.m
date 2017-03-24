//
//  DMImagePickerCollectionViewCell.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMImagePickerCollectionViewCell.h"
#import "BaseViewHeader.h"
@interface DMImagePickerCollectionViewCell()

@end

@implementation DMImagePickerCollectionViewCell

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

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _contentImageView.clipsToBounds = YES;
    }
    return _contentImageView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.imageEdgeInsets = UIEdgeInsetsMake(-5, 5, 5, -5);
    }
    return _selectButton;
}




#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.contentView addSubview:self.contentImageView];
    [self.contentView addSubview:self.selectButton];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.contentView);
        make.height.width.mas_equalTo(self.frame.size.width*0.4);
    }];
}


@end
