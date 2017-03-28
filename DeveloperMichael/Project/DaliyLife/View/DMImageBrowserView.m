//
//  DMImageBrowserView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/27.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMImageBrowserView.h"

@interface DMImageBrowserView()



@end

@implementation DMImageBrowserView

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
        _bottomView.backgroundColor = kColorByRGB(0, 0, 0, 0.8);
    }
    return _bottomView;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [_doneButton setTitleColor:kColorByRGB(5, 181, 15, 1) forState:UIControlStateNormal];
        _doneButton.enabled = NO;
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:17.0]];
        _doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _doneButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(kScreenWidth(), kScreenHeight());
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    self.titleLabel.text = @"Photo Browse";
    self.navBarImageView.backgroundColor = kColorByRGB(0, 0, 0, 0.8);
    [self.rightButton setTitle:@"" forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"no_select"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.doneButton];
    [self bringSubviewToFront:self.navBarView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(kScreenHeightRatio(40));
    }];     
    [_doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-7.5);
        make.top.bottom.mas_equalTo(_bottomView);
        make.width.mas_equalTo(kScreenWidthRatio(40));
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


@end
