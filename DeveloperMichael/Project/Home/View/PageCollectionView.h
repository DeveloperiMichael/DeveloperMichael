//
//  PageCollectionView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"

@protocol PageCollectionViewDataSource;
@protocol PageCollectionViewDelegate;

@interface PageCollectionView : BaseView

@property (nonatomic, weak) id<PageCollectionViewDelegate> page_delegate;
@property (nonatomic, weak) id<PageCollectionViewDataSource> page_dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign, readonly) NSUInteger currentIndex;

@end


@protocol PageCollectionViewDataSource <NSObject>

@required

///page number
- (NSUInteger)numberOfCollectionViewCellInPageView:(PageCollectionView *)pageCollectionView;

@optional

///cell front view
- (Class)collectionFrontCellClassInPageView:(PageCollectionView *)pageCollectionView;

///cell back view
- (Class)collectionBackCellClassInPageView:(PageCollectionView *)pageCollectionView;

- (void)pageView:(PageCollectionView *)pageView deployCollectionViewCell:(UICollectionViewCell *)collectionViewCell index:(NSUInteger)index isFront:(BOOL)isFront;


@end

@protocol PageCollectionViewDelegate <NSObject>




@end
