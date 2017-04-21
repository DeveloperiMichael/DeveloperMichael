//
//  DMCollectionWaterFlowLayout.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "WaterFlowCollectionViewLayout.h"

@interface WaterFlowCollectionViewLayout()

@property (nonatomic, strong) NSMutableDictionary *maxYdic;

@end

@implementation WaterFlowCollectionViewLayout


#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configDefaultData];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    __block NSString *maxCol = @"0";
    //找出最短列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString  *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue]>[self.maxYdic[maxCol] floatValue]) {
            maxCol = column;
        }
    }];
    return CGSizeMake(0, [self.maxYdic[maxCol] floatValue]);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    __block NSString * minCol = @"0";
    //找出最短的列
    [self.maxYdic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue]<[self.maxYdic[minCol] floatValue]) {
            minCol = column;
        }
    }];
    //    计算宽度
    CGFloat width = (self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-(self.colCount-1)*self.colMagrin)/self.colCount;
    //    计算高度
    CGFloat hight = [self.delegate waterFlowLayout:self heightByWidth:width atIndexPath:indexPath];
    //    CGFloat hight =100+arc4random_uniform(100);
    CGFloat x = self.sectionInset.left + (width+ self.colMagrin)* [minCol intValue];
    CGFloat y =[self.maxYdic[minCol] floatValue]+self.rowMagrin;
    //    更新最大的y值
    self.maxYdic[minCol] = @(y+hight);
    //    计算位置
    UICollectionViewLayoutAttributes * attri =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(x, y, width, hight);
    return attri;
    
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    for(int i = 0;i<self.colCount;i++)
    {
        NSString * col = [NSString stringWithFormat:@"%d",i];
        self.maxYdic[col] = @0;
    }
    
    NSMutableArray * array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return  array;
}

#pragma mark-
#pragma mark- Getters && Setters

- (NSMutableDictionary *)maxYdic {
    if (!_maxYdic) {
        _maxYdic = [[NSMutableDictionary alloc] init];
    }
    return _maxYdic;
}




#pragma mark-
#pragma mark- SetupConstraints

- (void)configDefaultData{
    self.colCount = 3;
    self.colMagrin = 10;
    self.rowMagrin = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
}




@end
