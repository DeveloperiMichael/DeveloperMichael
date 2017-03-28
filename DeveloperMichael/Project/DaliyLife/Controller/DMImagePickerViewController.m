//
//  DMImagePickerViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/20.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DMImagePickerViewController.h"
#import "BaseViewHeader.h"
#import "DMImagePickerView.h"
#import "DMImagePickerCollectionViewCell.h"
#import "ImageModel.h"
#import "SystemPhotoManager.h"
#import "DateUtil.h"
#import "DMImageBrowserViewController.h"

@interface DMImagePickerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BaseViewDelegate>

{
    float kCollectionImageLength;
    UICollectionViewFlowLayout *layout;
    BOOL _canAnimate;
}

@property (nonatomic, strong) NSArray *allAssetArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) DMImagePickerView *imagePickerView;
@property (nonatomic, strong) NSMutableArray *selectAssetArray;

@end

@implementation DMImagePickerViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _allAssetArray = [[SystemPhotoManager shareSystemPhotoManagerInstance] getAllAssetInPhotoAblumWithAscending:YES];
    
    [self configDefault];
    [self setupSubviewsContraints];
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
    return self.allAssetArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kScreenWidthRatio(5), kScreenWidthRatio(5), kScreenWidthRatio(5), kScreenWidthRatio(5));
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    PHAsset *asset = _allAssetArray[indexPath.row];
    [self getImageWithAsset:asset completion:^(UIImage *image) {
        cell.contentImageView.image=image;
    }];
    
    if (asset.isSelected) {
        [cell.selectButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }else{
        [cell.selectButton setImage:[UIImage imageNamed:@"no_select"] forState:UIControlStateNormal];
    }
    cell.selectButton.tag = 1000+indexPath.row;
    [cell.selectButton addTarget:self action:@selector(cellSelectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (_canAnimate) {
        [cell.selectButton.layer transformScaleBasicAnimationFromValue:1.0 toValue:1.2];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DMImageBrowserViewController *vc = [[DMImageBrowserViewController alloc] init];
    vc.imageAssetArray = self.allAssetArray;
    vc.currentIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark-
#pragma mark- Event response

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cellSelectButtonPressed:(UIButton *)button {
    
    //选中状态操作
    _canAnimate = YES;
    PHAsset *asset = _allAssetArray[button.tag-1000];
    if (_selectAssetArray.count>=9&&asset.isSelected==NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DeveloperMichael Tip" message:@"9 images limited" delegate:self cancelButtonTitle:@"Sure" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    asset.isSelected = !asset.isSelected;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:button.tag-1000 inSection:0];
    [_collectionView reloadItemsAtIndexPaths:@[indexPath]];

    //选中数据操作
    if (asset.isSelected) {
        [self.selectAssetArray addObject:asset];
    }else{
        [self.selectAssetArray enumerateObjectsUsingBlock:^(PHAsset  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[DateUtil stringFromDate:obj.creationDate withDateFormat:@"yymmddHHmmss"] isEqualToString:[DateUtil stringFromDate:asset.creationDate withDateFormat:@"yymmddHHmmss"]]) {
                [self.selectAssetArray removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
    }
    
    //bottomView 操作
    BOOL selectAssetArrayCount = _selectAssetArray.count==0?NO:YES;
    _imagePickerView.previewButton.enabled = selectAssetArrayCount;
    _imagePickerView.doneButton.enabled = selectAssetArrayCount;
    _imagePickerView.doneButton.selected = selectAssetArrayCount;
    _imagePickerView.previewButton.selected = selectAssetArrayCount;
    _imagePickerView.numberLabel.hidden = !selectAssetArrayCount;
    
    _imagePickerView.numberLabel.text = [NSString stringWithFormat:@"%li",(long)_selectAssetArray.count];
    [_imagePickerView.numberLabel.layer transformScaleBasicAnimationFromValue:1.0 toValue:1.2];
}

- (void)previewButtonPressed:(UIButton *)button {
    
}

- (void)doneButtonPressed:(UIButton *)button {
    if (self.finishSelectBlock) {
        self.finishSelectBlock(_selectAssetArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods

/* 默认配置 */
- (void)configDefault {
    _gridCount = 4;
    kCollectionImageLength = (kScreenWidth()-kScreenWidthRatio(5)*(_gridCount+1))/_gridCount;
    _maxSelectCount = 9;
    
}

//从这个回调中获取所图片
- (void)getImageWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *image))completion
{
    CGSize size = [self getSizeWithAsset:asset];
    [[SystemPhotoManager shareSystemPhotoManagerInstance] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:completion];
}
//获取图片及图片尺寸的相关方法
- (CGSize)getSizeWithAsset:(PHAsset *)asset
{
    CGFloat width  = (CGFloat)asset.pixelWidth;
    CGFloat height = (CGFloat)asset.pixelHeight;
    CGFloat scale = width/height;
    
    return CGSizeMake(self.collectionView.frame.size.height*scale, self.collectionView.frame.size.height*scale);
}


#pragma mark-
#pragma mark- Getters && Setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = kScreenWidthRatio(5);
        layout.minimumLineSpacing = kScreenWidthRatio(5);
        layout.itemSize = CGSizeMake(kCollectionImageLength, kCollectionImageLength);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DMImagePickerCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
        
    }
    return _collectionView;
}

- (DMImagePickerView *)imagePickerView {
    if (!_imagePickerView) {
        _imagePickerView = [[DMImagePickerView alloc] init];
        [_imagePickerView.previewButton addTarget:self action:@selector(previewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_imagePickerView.doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _imagePickerView.delegate = self;
    }
    return _imagePickerView;
}

- (void)setGridCount:(NSInteger)gridCount {
    _gridCount = gridCount;
    kCollectionImageLength = (kScreenWidth()-kScreenWidthRatio(5)*(_gridCount+1))/_gridCount;
    layout.itemSize = CGSizeMake(kCollectionImageLength, kCollectionImageLength);
}

- (NSMutableArray *)selectAssetArray {
    if (!_selectAssetArray) {
        _selectAssetArray = [[NSMutableArray alloc] init];
    }
    return _selectAssetArray;
}

- (void)setMaxSelectCount:(NSInteger)maxSelectCount {
    _maxSelectCount = maxSelectCount;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.imagePickerView];
    [self.imagePickerView addSubview:self.collectionView];
    [_imagePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_imagePickerView);
        make.top.mas_equalTo(self.imagePickerView.navBarView.mas_bottom).mas_offset(kScreenHeightRatio(5));
        make.bottom.mas_equalTo(-kScreenHeightRatio(40));
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
