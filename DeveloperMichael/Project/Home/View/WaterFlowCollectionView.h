//
//  WaterFlowCollectionView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"
#import "WaterFlowCollectionViewLayout.h"

@interface WaterFlowCollectionView : BaseView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterFlowCollectionViewLayout *layout;
@end
