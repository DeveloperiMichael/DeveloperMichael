//
//  SystemPhotoManager.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/22.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

//建一个内部类
@interface DMAblumList : NSObject
@property (nonatomic, copy) NSString *ablumName; //相册名字
@property (nonatomic, assign) NSInteger photoNumber; //该相册内相片数量
@property (nonatomic, strong) PHAsset *headImageAsset; //相册第一张图片缩略图
@property (nonatomic, strong) PHAssetCollection *assetCollection; //相册集，通过该属性获取该相册集下所有照片
@end


@interface SystemPhotoManager : NSObject

+ (instancetype)shareSystemPhotoManagerInstance;


/**
 * @brief 获取用户所有相册列表
 */
- (NSArray<DMAblumList *> *)getPhotoAblumList;


/**
 * @brief 获取相册内所有图片资源
 * @param ascending 是否按创建时间正序排列 YES,创建时间正（升）序排列; NO,创建时间倒（降）序排列
 */
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;


/**
 * @brief 获取指定相册内的所有图片
 */
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;


/**
 * @brief 获取每个Asset对应的图片
 */
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;

@end
