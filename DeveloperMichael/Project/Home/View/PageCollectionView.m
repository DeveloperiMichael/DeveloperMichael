//
//  PageCollectionView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PageCollectionView.h"
#import "PageCollectionViewLayout.h"

static NSString *const kFrontCellIdentifier = @"com.homeCollection.frontCell.identifier";
static NSString *const kBackCellIndetifier = @"com.homeCollection.backCell.identifier";
static NSString *const kLoadCellIdentifier = @"com.homeCollection.loadCell.identifier";

@interface PageCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign) NSUInteger itemNumber;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGesture;
@property (nonatomic, strong) UICollectionViewCell *originalCell;
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation PageCollectionView {
    BOOL _canShowBackView;
    BOOL _isShowBackView;
    BOOL _doubleTapToReload;
    BOOL _shouldShowLoadCell;
}


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviewsContraints];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self configDefaultData];
}

#pragma mark-
#pragma mark- delegate

#pragma mark-
#pragma mark- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemNumber;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (_shouldShowLoadCell && indexPath.item == _itemNumber) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLoadCellIdentifier forIndexPath:indexPath];
        cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.layer.shadowOffset = CGSizeZero;
        cell.layer.shadowOpacity = 0.25;
        cell.layer.shadowRadius = 9.0f;
        cell.layer.cornerRadius = 5.0f;
        cell.contentView.layer.masksToBounds  = YES;
    }else {
        if (_canShowBackView && _isShowBackView) {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBackCellIndetifier forIndexPath:indexPath];
            cell.layer.masksToBounds  = YES;
        }else {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFrontCellIdentifier forIndexPath:indexPath];
            cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            cell.layer.shadowOffset = CGSizeZero;
            cell.layer.shadowOpacity = 0.25;
            cell.layer.shadowRadius = 9.0f;
            cell.contentView.layer.masksToBounds  = YES;
        }
        cell.layer.cornerRadius = 5.0f;
        cell.backgroundColor = [UIColor whiteColor];
        if ([self.page_dataSource respondsToSelector:@selector(pageView:deployCollectionViewCell:index:isFront:)]) {
            [self.page_dataSource pageView:self deployCollectionViewCell:cell index:indexPath.item isFront:!(_canShowBackView && _isShowBackView)];
        }
        
        if (_doubleTapToReload) {
            _doubleTapToReload = NO;
            [UIView transitionFromView:_originalCell toView:cell duration:0.5 options:_isShowBackView ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight completion:NULL];
        }
    }
    
    return cell;

}


#pragma mark-
#pragma mark- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isShowBackView = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat a  = (self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds)) - self.currentIndex;
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    if (([cell.reuseIdentifier isEqualToString:kBackCellIndetifier]) && (-0.5 < a && a < 0.5)) {
        _isShowBackView = YES;
    }else {
        _isShowBackView = NO;
    }
    self.currentIndex = roundl(self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat a  = (self.collectionView.contentOffset.x / CGRectGetWidth(self.collectionView.bounds)) - self.currentIndex;
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    if (([cell.reuseIdentifier isEqualToString:kBackCellIndetifier]) && (-0.5 < a && a < 0.5)) {
        _isShowBackView = YES;
    }else {
        _isShowBackView = NO;
    }
}

#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

- (void)reloadData {
    //处理加载的cell
    self.itemNumber = [self.page_dataSource numberOfCollectionViewCellInPageView:self];
    [self.collectionView reloadData];
}

- (void)configDefaultData {
    self.itemNumber = [self.page_dataSource numberOfCollectionViewCellInPageView:self];
}

- (void)readDataSource:(id<PageCollectionViewDataSource>)page_dataSource {
    //register front cell
    if ([page_dataSource respondsToSelector:@selector(collectionFrontCellClassInPageView:)]&&[page_dataSource collectionFrontCellClassInPageView:self]) {
        [self.collectionView registerClass:[page_dataSource collectionFrontCellClassInPageView:self] forCellWithReuseIdentifier:kFrontCellIdentifier];
    }else {
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kFrontCellIdentifier];
    }
    
    //register back cell
    if ([page_dataSource respondsToSelector:@selector(collectionBackCellClassInPageView:)]&&[page_dataSource collectionBackCellClassInPageView:self]) {
        [self.collectionView registerClass:[page_dataSource collectionBackCellClassInPageView:self] forCellWithReuseIdentifier:kBackCellIndetifier];
        _canShowBackView = YES;
        if (![self.collectionView.gestureRecognizers containsObject:self.doubleTapGesture]) {
            _doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureInCollectionViewAction:)];
            _doubleTapGesture.numberOfTapsRequired = 2;
            [self.collectionView addGestureRecognizer:_doubleTapGesture];
        }
        
    }
}

- (void)doubleTapGestureInCollectionViewAction:(UITapGestureRecognizer *)doubleTapGesture {
    if (_canShowBackView && self.currentIndex < self.itemNumber) {
        _originalCell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
        if (([_originalCell.reuseIdentifier isEqualToString:kBackCellIndetifier]&&_isShowBackView)||([_originalCell.reuseIdentifier isEqualToString:kFrontCellIdentifier]&&!_isShowBackView)) {
            _doubleTapToReload = YES;
            _isShowBackView = !_isShowBackView;
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.currentIndex inSection:0]]];
        }
    }
}


#pragma mark-
#pragma mark- Getters && Setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        PageCollectionViewLayout *layout = [[PageCollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"pageCollectionView"];
    }
    return _collectionView;
}

- (void)setPage_dataSource:(id<PageCollectionViewDataSource>)page_dataSource {
    if (_page_dataSource != page_dataSource) {
        _page_dataSource = page_dataSource;
        [self readDataSource:page_dataSource];
    }
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBarView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
    }];
}
  

@end
