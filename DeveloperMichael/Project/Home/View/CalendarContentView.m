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


- (UICollectionView *)contentCollectionView {
    if (!_contentCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.itemSize = CGSizeMake((kScreenWidth()-kScreenWidthRatio(45))/3, (kScreenHeight()-64-kScreenHeightRatio(21))/8);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _contentCollectionView.bounces = NO;
    }
    return _contentCollectionView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.contentCollectionView];
    [_contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(kScreenWidthRatio(45));
        make.bottom.mas_equalTo(self).mas_offset(-kScreenHeightRatio(21));
    }];
}


@end
