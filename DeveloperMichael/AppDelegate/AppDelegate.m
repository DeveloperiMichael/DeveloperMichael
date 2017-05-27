//
//  AppDelegate.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "IQKeyboardManager.h"
#import "TalkingData.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    //[TalkingData sessionStarted:@"AF8D44C5FDED4EC3823F2154E93AF40A" withChannelId:@"123456789"];
    
    //[TalkingData trackEvent:@"8511033a8fc7401a879679dad602cac0"];
    
    //配置推送
    [self setupPushWithLaunchOptions:launchOptions];
    
    //键盘处理设置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    //初始化处理AppDelegate事物的控制器
    _appDelegateCtrl = [[AppDelegateViewController alloc] initWithWindow:self.window
                                                      remoteNotification:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]
                                                       localNotification:launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]];
    return YES;
    
}

/** 配置推送 */
- (void)setupPushWithLaunchOptions:(NSDictionary *)launchOptions {
    // 设置应用程序的图标右上角的数字
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:888];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0){
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

/** 获取DeviceToken */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if (_appDelegateCtrl) [_appDelegateCtrl controllerApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

/** app 非killed 状态下本地推送点击事件 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    if (_appDelegateCtrl) [_appDelegateCtrl controllerApplication:application didReceiveLocalNotification:notification];
}

/** app 非killed 状态下远程推送点击事件 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (_appDelegateCtrl) [_appDelegateCtrl controllerApplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"UIApplicationStateInactive");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"UIApplicationStateBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"UIApplicationStateActive");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"UIApplicationStateActive");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"UIApplicationStateKill");
}


@end
