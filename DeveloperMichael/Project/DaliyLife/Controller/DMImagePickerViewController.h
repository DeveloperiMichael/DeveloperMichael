//
//  DMImagePickerViewController.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/20.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 照片选择回调 */
typedef void(^finishBlock)(NSArray *selectArray);

@interface DMImagePickerViewController : UINavigationController

/* 一行几格 */
@property (nonatomic, assign) NSInteger gridCount;

@property (nonatomic, copy) finishBlock finishSelectBlock;

/* 可选照片数量 default is 9*/
@property (nonatomic, assign) NSInteger maxSelectCount;

@end
