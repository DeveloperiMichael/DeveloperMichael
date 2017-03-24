//
//  ImageModel.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ImageModel : NSObject

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) PHAsset *asset;

@end
