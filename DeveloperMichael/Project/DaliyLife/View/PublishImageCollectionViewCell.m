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

- (instancetype)init {
    self = [super init];
    if (self) {
        _gridCount = 4;
        kCollectionImageLength = (kScreenWidth()-kScreenWidthRatio(5)*(_gridCount+1))/_gridCount;
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

- (void)setGridCount:(NSInteger)gridCount {
    
    [self.publishImageView removeFromSuperview];
    [self.selectButton removeFromSuperview];
    
    _gridCount = gridCount;
    if (_gridCount==0) {
        _gridCount = 4;
    }
    kCollectionImageLength = (kScreenWidth()-kScreenWidthRatio(5)*(_gridCount+1))/_gridCount;
    [self setupSubviewsContraints];
}



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
        _selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
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
