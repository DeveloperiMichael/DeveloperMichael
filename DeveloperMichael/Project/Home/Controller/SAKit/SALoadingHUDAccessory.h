//
//  SALoadingHUDAccessory.h
//  DeveloperMichael
//
//  Created by 张炯 on 2017/6/15.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SALoadingHUDAccessory : NSObject


/**
 初始化LoadingHUDAccessory

 @param view LoadingHUDAccessory需要展示的界面
 */
- (instancetype)initWithShowInView:(UIView *)view withText:(NSString *)string;

/**
 开始加载动画
 */
- (void)startLoadingAnimation;


/**
 停止动画
 */
- (void)stopLoadingAnimation;

@end
