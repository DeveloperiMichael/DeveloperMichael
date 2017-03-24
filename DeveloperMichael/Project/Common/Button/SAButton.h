//
//  SAButton.h
//  ZJKeepDevelop
//
//  Created by 张炯 on 16/11/17.
//  Copyright © 2016年 zhangjiong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ImageTitleLocationType) {
    ImageLocateLeftAndTotalCenter=0,
    ImageLocateRightAndTotalCenter,
    ImageLocateLeftAndTotalLeft,
    ImageLocateRightAndTotalLeft,
    ImageLocateLeftAndTotalRight,
    ImageLocateRightAndTotalRight,
    ImageLocateTopAndTotalCenter,
    ImageLocateBottomAndTotalCenter,
};

@interface SAButton : UIButton

@property(nonatomic,assign) ImageTitleLocationType locationType;

/*
 Image、Title之间间隔
 必须在设置locationType之前设置
 */

@property(nonatomic,assign) float interval;


@end
