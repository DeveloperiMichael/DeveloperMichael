//
//  DMImageBrowserView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/27.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"

@interface DMImageBrowserView : BaseView

/* 完成 */
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *bottomView;

@end
