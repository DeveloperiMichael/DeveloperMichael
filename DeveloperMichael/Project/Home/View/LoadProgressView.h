//
//  ProgressView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>


///ProgressView
@interface LoadProgressView : UIView

///default is 2
@property (nonatomic, assign) CGFloat progressWidth;

///default is graycolor
@property (nonatomic, strong) UIColor *progressColor;

///animation duration,default is 1.0
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  添加通知 当程序重新进入前台或活跃状态，动画仍然会执行
 */
- (void)addNotificationObserver;

@end
