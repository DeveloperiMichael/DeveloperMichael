//
//  PublishViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishImageCollectionViewCell.h"
#import "PublishView.h"
#import "DMImagePickerViewController.h"
#import <objc/runtime.h>
#import "SystemPhotoManager.h"

@interface PublishViewController ()<BaseViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) PublishView *publishView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger gridCount;

@end

@implementation PublishViewController


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithGridCount:(NSInteger)gridCount {
    self = [super init];
    if (self) {
        _gridCount = gridCount;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _gridCount = 4;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- SACardViewDataSource




#pragma mark-
#pragma mark- delegate

#pragma mark- <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kScreenWidthRatio(5), kScreenWidthRatio(5), kScreenWidthRatio(5), kScreenWidthRatio(5));
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublishImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    cell.gridCount = _gridCount;
    if (_imageArray.count == 1) {
        cell.publishImageView.image=_imageArray[0];
        cell.selectButton.hidden = YES;
    }else{
        if (indexPath.row == _imageArray.count-1) {
            cell.publishImageView.image=_imageArray[_imageArray.count-1];
            cell.selectButton.hidden = YES;
        }else{
            PHAsset *asset = _imageArray[indexPath.row];
            [self getImageWithAsset:asset completion:^(UIImage *image) {
                cell.publishImageView.image=image;
                cell.selectButton.hidden = NO;
            }];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //PublishImageCollectionViewCell *cell = (PublishImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == _imageArray.count-1) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"photo & video",@"photograph album", nil];
        [sheet showInView:self.view];
    }
}


#pragma mark- <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            //photo & video
        }
            break;
        case 1:
        {
            //photograph album
            DMImagePickerViewController *vc = [[DMImagePickerViewController alloc] initWithGridCount:5];
            vc.finishSelectBlock =^(NSArray *selectArray){
                [self.imageArray removeLastObject];
                [self.imageArray addObjectsFromArray:selectArray];
                UIImage *image = [UIImage imageNamed:@"icon_add"];
                [self.imageArray addObject:image];
                
                NSInteger lineNumber = self.imageArray.count/_gridCount;
                
                [_publishView.collectionView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}



#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

- (void)getImagePhotographAlbum
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
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
    return CGSizeMake(_publishView.collectionView.view_width*scale, _publishView.collectionView.view_width*scale);
    
}




#pragma mark-
#pragma mark- Getters && Setters

- (PublishView *)publishView {
    if (!_publishView) {
        _publishView = [[PublishView alloc] initWithGridCount:_gridCount];
        _publishView.delegate = self;
        _publishView.backgroundColor = kColorByRGB(0, 0, 0, 0.3);
        _publishView.collectionView.delegate = self;
        _publishView.collectionView.dataSource = self;
        [_publishView.collectionView registerClass:[PublishImageCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    }
    return _publishView;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
        UIImage *image = [UIImage imageNamed:@"icon_add"];
        [_imageArray addObject:image];
    }
    return _imageArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.publishView];
    [_publishView mas_makeConstraints:^(MASConstraintMaker *make) {
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
