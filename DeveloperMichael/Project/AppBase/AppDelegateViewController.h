//
//  AppDelegateViewController.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/28.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegateViewController : UIViewController


/**
 初始化处理AppDelegate事物的控制器

 @param window App main Window
 @param remoteInfo 远程推送
 @param localInfo 本地推送
 @return self
 */
- (instancetype)initWithWindow:(UIWindow *)window
            remoteNotification:(NSDictionary *)remoteInfo
             localNotification:(NSDictionary *)localInfo;


/** 推送相关方法 */
- (void)controllerApplication:application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)controllerApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)controllerApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

- (void)startLoadAdvertiseViewController;
- (void)startLoadHomeViewController;
- (void)startLoadLoginViewController;

@end
