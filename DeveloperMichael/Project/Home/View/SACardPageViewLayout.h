//
//  SACardCollectionViewLayout.h
//  SACardDemo
//
//  Created by 詹学宝 on 17/2/6.
//  Copyright © 2017年 学宝工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SACardPageViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat innerHorizontalSpace;

@property (nonatomic, assign) CGFloat innerTopSpace;

@property (nonatomic, assign) CGFloat innerBottomSpace;

@property (nonatomic, assign) NSInteger visibleCount;

@end
