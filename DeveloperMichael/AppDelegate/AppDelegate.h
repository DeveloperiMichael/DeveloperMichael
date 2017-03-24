//
//  AppDelegate.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegateViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 将AppDelegate要处理的东西转移到这个控制器处理 */
@property (nonatomic, strong) AppDelegateViewController *appDelegateCtrl;
@end

