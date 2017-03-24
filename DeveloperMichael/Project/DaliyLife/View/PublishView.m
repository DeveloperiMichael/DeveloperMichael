//
//  PublishView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PublishView.h"

@interface PublishView ()

{
    float kCollectionImageLength;
}

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

@end

@implementation PublishView

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


- (UIPlaceholderTextView *)placeholderTextView {
    if (!_placeholderTextView) {
        _placeholderTextView = [[UIPlaceholderTextView alloc] init];
        _placeholderTextView.placeholder = @"follow your heart...";
        _placeholderTextView.textColor = kColorByRGB(223, 223, 223, 1);
        _placeholderTextView.backgroundColor = [UIColor clearColor];
        _placeholderTextView.textFont = [UIFont systemFontOfSize:14.0];
        _placeholderTextView.placeholderColor = kColorByRGB(153, 153, 153, 1);
        _placeholderTextView.layer.masksToBounds = YES;
        _placeholderTextView.limitCharacter = 20;
        _placeholderTextView.layer.cornerRadius = 3;
    }
    return _placeholderTextView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = kScreenWidthRatio(5);
        layout.minimumLineSpacing = kScreenWidthRatio(5);
        layout.itemSize = CGSizeMake(kCollectionImageLength, kCollectionImageLength);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
    }
    return _collectionView;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = kColorByRGB(153, 153, 153, 0.2);
    }
    return _lineView2;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:14.0];
        _tipLabel.text = @"photos & videos";
        _tipLabel.textColor = kColorByRGB(153, 153, 153, 1);
        _tipLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _tipLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = kColorByRGB(153, 153, 153, 0.2);
    }
    return _lineView1;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.placeholderTextView];
    [self addSubview:self.lineView1];
    [self addSubview:self.tipLabel];
    [self addSubview:self.lineView2];
    [self addSubview:self.collectionView];
    self.titleLabel.text = @"Daliy Life";
    [self.leftButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.rightButton setTitle:@"Publish" forState:UIControlStateNormal];
    [_placeholderTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBarView.mas_bottom);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(kScreenHeightRatio(120));
    }];
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(5));
        make.right.mas_equalTo(-kScreenWidthRatio(5));
        make.top.mas_equalTo(_placeholderTextView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(5));
        make.right.mas_equalTo(-kScreenWidthRatio(5));
        make.top.mas_equalTo(_placeholderTextView.mas_bottom);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tipLabel.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(kCollectionImageLength+kScreenWidthRatio(10));
    }];
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(5));
        make.right.mas_equalTo(-kScreenWidthRatio(5));
        make.top.mas_equalTo(_collectionView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
}


@end
