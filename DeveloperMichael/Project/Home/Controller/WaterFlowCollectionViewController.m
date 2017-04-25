//
//  WaterFlowCollectionViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "WaterFlowCollectionViewController.h"
#import "WaterFlowCollectionView.h"
#import "CommodityModel.h"
#import "CommodityCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface WaterFlowCollectionViewController ()<WaterFlowCollectionViewLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,BaseViewDelegate>

@property (nonatomic, strong) WaterFlowCollectionView *flowCollectionView;
@property (nonatomic, strong) NSMutableArray *commodityArray;

@end

@implementation WaterFlowCollectionViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
    [self configBaseData];
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
#pragma mark- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.commodityArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommodityCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommodityCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    CommodityModel *model = _commodityArray[indexPath.item];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:nil];
    cell.priceLabel.text = model.price;
    return cell;
}

#pragma mark-
#pragma mark- WaterFlowCollectionViewLayoutDelegate

//代理方法
- (CGFloat)waterFlowLayout:(WaterFlowCollectionViewLayout *)layout heightByWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    CommodityModel *shop = _commodityArray[indexPath.item];
    return shop.h/shop.w*width;
}



#pragma mark-
#pragma mark- Event response

- (void)rightButtonClicked:(BaseView *)view {
    
}

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods

- (void)configBaseData {
    NSArray * shopsArray = [CommodityModel objectArrayWithFilename:@"2.plist"];
    [self.commodityArray addObjectsFromArray:shopsArray];
}


#pragma mark-
#pragma mark- Getters && Setters

- (WaterFlowCollectionView *)flowCollectionView {
    if (!_flowCollectionView) {
        _flowCollectionView = [[WaterFlowCollectionView alloc] init];
        _flowCollectionView.titleLabel.text = self.navigationBarTitle;
        _flowCollectionView.collectionView.dataSource = self;
        _flowCollectionView.collectionView.delegate = self;
        _flowCollectionView.layout.delegate = self;
        _flowCollectionView.delegate = self;
        [_flowCollectionView.collectionView registerClass:[CommodityCollectionViewCell class] forCellWithReuseIdentifier:@"CommodityCollectionViewCell"];
    }
    return _flowCollectionView;
}

- (NSMutableArray *)commodityArray {
    if (!_commodityArray) {
        _commodityArray = [[NSMutableArray alloc] init];
    }
    return _commodityArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.flowCollectionView];
    [_flowCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


@end
