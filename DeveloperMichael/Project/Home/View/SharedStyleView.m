//
//  SharedStyleView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/27.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "SharedStyleView.h"
#import "BaseViewHeader.h"
#import "SnailQuickMaskPopups.h"
#import "ShareCollectionViewCell.h"

@interface SharedStyleView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSArray *shareTitleArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation SharedStyleView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.view_height = 300;
        self.view_width = kScreenWidth();
        self.backgroundColor = [UIColor whiteColor];
        _shareTitleArray = [[NSArray alloc] initWithObjects:@"微信好友",@"朋友圈",@"新浪微博",@"QQ好友",@"跳转", nil];
        [self setupMaskPopups];
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shareTitleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_shareTitleArray[indexPath.row]]];
    cell.platformLabel.text = _shareTitleArray[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, (kScreenWidth()-85*3)/4, 10, (kScreenWidth()-85*3)/4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_popups dismissAnimated:YES completion:nil];
}


#pragma mark-
#pragma mark- Event response

- (void)show {
    [_popups presentAnimated:YES completion:nil];
}

- (void)cancelButtonPressed:(UIButton *)button {
    [_popups dismissAnimated:YES completion:nil];
}
#pragma mark-
#pragma mark- Private Methods

- (void)setupMaskPopups {
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:self];
    _popups.presentationStyle = PresentationStyleBottom;
    _popups.isAllowPopupsDrag = YES;
    _popups.dampingRatio = 1.0;
}


#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:18.0]];
        _titleLabel.text = @"分享到：";
        _titleLabel.textColor = kColorByRGB(51, 51, 51, 1);
    }
    return _titleLabel;
}

- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(85, 85);
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor clearColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:[ShareCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        
    }
    return _collection;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.backgroundColor = kColorByRGB(243, 243, 243, 1);
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:18.0]];
        [_cancelButton setTitle:@"取  消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kColorByRGB(0, 0, 0, 1) forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.titleLabel];
    [self addSubview:self.collection];
    [self addSubview:self.cancelButton];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(50);
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.bottom.mas_equalTo(_cancelButton.mas_top);
    }];
}

@end
