//
//  DMImageBrowserViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/24.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMImageBrowserViewController.h"
#import "DMImageBrowserView.h"
#import "DMImageBroswerCollectionViewCell.h"
#import "SystemPhotoManager.h"

@interface DMImageBrowserViewController ()<BaseViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

{
    BOOL shouldHideToolView;
}

@property(nonatomic, strong) DMImageBrowserView *imageBrowserView;

@end

@implementation DMImageBrowserViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
    
    self.imageBrowserView.collectionView.delegate = self;
    self.imageBrowserView.collectionView.dataSource = self;
    [self.imageBrowserView.collectionView registerClass:[DMImageBroswerCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [self.imageBrowserView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- SACardViewDataSource




#pragma mark-
#pragma mark- delegate

#pragma mark- <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageAssetArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMImageBroswerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    PHAsset *asset = self.imageAssetArray[indexPath.row];
    [self getImageWithAsset:asset completion:^(UIImage *image) {
        cell.contentImageView.image=image;
    }];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    shouldHideToolView = !shouldHideToolView;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (shouldHideToolView) {
            self.imageBrowserView.navBarView.alpha = 0;
            self.imageBrowserView.bottomView.alpha = 0;
        }else{
            self.imageBrowserView.navBarView.alpha = 1;
            self.imageBrowserView.bottomView.alpha = 1;
        }
    }];
    
}



#pragma mark-
#pragma mark- Event response

- (void)rightButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods

//从这个回调中获取所图片
- (void)getImageWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *image))completion
{
    CGSize size = [self getSizeWithAsset:asset];
    [[SystemPhotoManager shareSystemPhotoManagerInstance] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:completion];
}

//获取图片及图片尺寸的相关方法
- (CGSize)getSizeWithAsset:(PHAsset *)asset
{
    CGFloat width  = (CGFloat)asset.pixelWidth*0.5;
    CGFloat height = (CGFloat)asset.pixelHeight*0.5;
    CGFloat scale = width/height;
    
    if (height>width) {
        float imageHeight = height*scale>kScreenHeight()?kScreenHeight():height*scale;
        return CGSizeMake(kScreenWidth(),kScreenHeightRatio(imageHeight));
    }else{
        float imageWidth = width*scale>kScreenWidth()?kScreenWidth():width*scale;
        return CGSizeMake(kScreenHeightRatio(imageWidth), kScreenHeight());
    }
    
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}


#pragma mark-
#pragma mark- Getters && Setters

- (DMImageBrowserView *)imageBrowserView {
    if (!_imageBrowserView) {
        _imageBrowserView = [[DMImageBrowserView alloc] init];
        _imageBrowserView.delegate = self;
    }
    return _imageBrowserView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.imageBrowserView];
    [_imageBrowserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
