//
//  PageCollectionViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PageCollectionViewController.h"
#import "PageCollectionView.h"
#import "CommodityCollectionViewCell.h"

@interface PageCollectionViewController ()<BaseViewDelegate,PageCollectionViewDelegate,PageCollectionViewDataSource>

@property (nonatomic, strong) PageCollectionView *pageCollectionView;
@property (nonatomic, strong) UICollectionViewCell *frontView;
@property (nonatomic, strong) UICollectionViewCell *backView;


@end

@implementation PageCollectionViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- DataSource

- (Class)collectionFrontCellClassInPageView:(PageCollectionView *)pageCollectionView {
    return [CommodityCollectionViewCell class];
}

- (Class)collectionBackCellClassInPageView:(PageCollectionView *)pageCollectionView {
    return [CommodityCollectionViewCell class];
}

- (NSUInteger)numberOfCollectionViewCellInPageView:(PageCollectionView *)pageCollectionView {
    return 100;
}

- (void)pageView:(PageCollectionView *)pageView deployCollectionViewCell:(UICollectionViewCell *)collectionViewCell index:(NSUInteger)index isFront:(BOOL)isFront {
    CommodityCollectionViewCell *cell = (CommodityCollectionViewCell *)collectionViewCell;
    if ([cell.reuseIdentifier isEqualToString:@"com.homeCollection.frontCell.identifier"]) {
        cell.imgView.backgroundColor = kRandomColor;
    }else{
        cell.imgView.backgroundColor = [UIColor brownColor];
    }
}

//其实就是在这个方法里为cell添加了一个动画效果
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
    transform = CATransform3DTranslate(transform, 0, -100, 0);//左边水平移动
    transform = CATransform3DScale(transform, 0, 0, 0);//由小变大
    cell.layer.transform = transform;
    cell.layer.opacity = 0.0;
    [UIView animateWithDuration:0.6 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1;
    }];
}

#pragma mark-
#pragma mark- delegate


#pragma mark-
#pragma mark- Event response

- (void)rightButtonClicked:(BaseView *)view {
    
}

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (PageCollectionView *)pageCollectionView {
    if (!_pageCollectionView) {
        _pageCollectionView = [[PageCollectionView alloc] init];
        _pageCollectionView.delegate = self;
        _pageCollectionView.page_dataSource = self;
        _pageCollectionView.page_delegate = self;
        _pageCollectionView.titleLabel.text = self.navigationBarTitle;
    }
    return _pageCollectionView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.pageCollectionView];
    [_pageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


@end
