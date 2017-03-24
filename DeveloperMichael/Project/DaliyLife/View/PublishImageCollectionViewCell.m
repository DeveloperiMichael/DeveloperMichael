//
//  PublishImageCollectionViewCell.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/11.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PublishImageCollectionViewCell.h"
#import "BaseViewHeader.h"


@interface PublishImageCollectionViewCell ()

{
    float kCollectionImageLength;
}

@end


@implementation PublishImageCollectionViewCell


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        kCollectionImageLength = (kScreenWidth()-kScreenWidthRatio(5)*5)/4;
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

- (UIImageView *)publishImageView {
    if (!_publishImageView) {
        _publishImageView = [[UIImageView alloc] init];
    }
    return _publishImageView;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        _selectButton.backgroundColor = [UIColor redColor];
        _selectButton.imageEdgeInsets = UIEdgeInsetsMake(-5, 5, 5, -5);
    }
    return _selectButton;
}


- (void)setButtonImage:(UIImage *)buttonImage {
    [_selectButton setImage:buttonImage forState:UIControlStateNormal];
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.contentView addSubview:self.publishImageView];
    [self.contentView addSubview:self.selectButton];
    [_publishImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.contentView);
        make.height.width.mas_equalTo(kCollectionImageLength*0.3);
    }];
}


@end
