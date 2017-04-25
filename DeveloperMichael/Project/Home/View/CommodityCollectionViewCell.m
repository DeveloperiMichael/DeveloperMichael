//
//  CommodityCollectionViewCell.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CommodityCollectionViewCell.h"
#import "BaseViewHeader.h"
@implementation CommodityCollectionViewCell

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

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = kColorByRGB(0, 0, 0, 0.4);
        _priceLabel.textColor = [UIColor whiteColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:14.0]];
    }
    return _priceLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.imgView];
    [self addSubview:self.priceLabel];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
}


@end
