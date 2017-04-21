//
//  DMCollectionWaterFlowLayout.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFlowCollectionViewLayoutDelegate;


@interface WaterFlowCollectionViewLayout : UICollectionViewLayout

///section offset
@property (nonatomic, assign) UIEdgeInsets sectionInset;

///Line spacing
@property (nonatomic, assign) CGFloat rowMagrin;

///Column spacing
@property (nonatomic, assign) CGFloat colMagrin;

///Column count
@property (nonatomic, assign) NSInteger colCount;

@property (nonatomic, weak) id<WaterFlowCollectionViewLayoutDelegate> delegate;

@end

@protocol WaterFlowCollectionViewLayoutDelegate <NSObject>

///accroding to width get height
- (CGFloat)waterFlowLayout:(WaterFlowCollectionViewLayout *)layout heightByWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end
