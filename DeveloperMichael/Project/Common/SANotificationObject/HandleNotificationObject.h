//
//  HandleNotificationObject.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HandleNotificationObject : NSObject

/** 发送本地通知 */
+ (void)launchLocalNotificationWithContent:(NSDictionary *)content;

/** 接收到本地通知处理 */
+ (void)handleLocalNotificationWithLocalNotification:(UILocalNotification *)localNotification;
+ (void)handleRemoteNotificationWhenAppIsOnForegroundWithType:(NSString *)type aps:(NSDictionary *)aps msg:(NSDictionary *)msg;
+ (void)handleRemoteNotificationWhenAppIsOnBackgroundOrInactiveWithType:(NSString *)type aps:(NSDictionary *)aps msg:(NSDictionary *)msg ;
+ (void)cleanUpAllNotifications:(BOOL)animated;

@end
