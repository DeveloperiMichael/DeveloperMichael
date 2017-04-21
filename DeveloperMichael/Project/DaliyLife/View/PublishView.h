//
//  PublishView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"
#import "UIPlaceholderTextView.h"
@interface PublishView : BaseView

@property (nonatomic, strong) UIPlaceholderTextView *placeholderTextView;
@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithGridCount:(NSInteger)gridCount;

@end
