//
//  CalendarContentView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/5/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CalendarContentView.h"
#import "BaseViewHeader.h"
@interface CalendarContentView()



@end

@implementation CalendarContentView

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

- (UICollectionView *)calendarCollectionView {
    if (!_calendarCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _calendarCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.itemSize = CGSizeMake((kScreenWidth()-kScreenWidthRatio(45))/3, kScreenHeightRatio(kScreenHeightRatio(36)));
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _calendarCollectionView.bounces = NO;
        _calendarCollectionView.tag = 100;
        _calendarCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return _calendarCollectionView;
    
}


- (UICollectionView *)contentCollectionView {
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.itemSize = CGSizeMake((kScreenWidth()-kScreenWidthRatio(45))/3, (kScreenHeight()-64-kScreenHeightRatio(21)-kScreenHeightRatio(40))/7);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView.bounces = NO;
        _contentCollectionView.tag = 200;
    }
    return _contentCollectionView;
    
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.calendarCollectionView];
    [self addSubview:self.contentCollectionView];
    [_calendarCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kScreenWidthRatio(45));
        make.right.top.mas_equalTo(self);
        make.height.mas_equalTo(kScreenHeightRatio(36));
    }];
    [_contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_calendarCollectionView.mas_bottom);
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(kScreenWidthRatio(45));
        make.bottom.mas_equalTo(self).mas_offset(-kScreenHeightRatio(21));
    }];
}


@end
