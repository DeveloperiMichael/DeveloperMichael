//
//  ProgressView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadProgressView : UIView

/**
 初始化LoadProgressView
 
 @param view LoadProgressView需要展示的界面
 */
- (instancetype)initWithShowInView:(UIView *)view withText:(NSString *)string;



/**
 *  添加通知 当程序重新进入前台或活跃状态，动画仍然会执行
 */
- (void)addNotificationObserver;

@end
