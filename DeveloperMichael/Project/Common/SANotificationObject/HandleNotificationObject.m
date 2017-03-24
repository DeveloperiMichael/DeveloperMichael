//
//  HandleNotificationObject.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "HandleNotificationObject.h"
#import "HandleNotificationView.h"

@implementation HandleNotificationObject

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

/** 发送本地通知 */
+ (void)launchLocalNotificationWithContent:(NSDictionary *)content {
    // 1.创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 2.设置本地通知的内容
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    localNote.alertBody = @"这是一个本地通知";
    localNote.alertAction = @"解锁";
    localNote.hasAction = NO;
    localNote.alertLaunchImage = @"640_960";
    localNote.alertTitle = @"DeveloperMichael的一条新通知";
    localNote.soundName = @"buyao.wav";
    localNote.applicationIconBadgeNumber = 999;
    localNote.userInfo = @{@"type" : @"DeveloperMichael"};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

/** 本地通知处理 */
+ (void)handleLocalNotificationWithLocalNotification:(UILocalNotification *)localNotification {
    NSDictionary *content = localNotification.userInfo;
    if ([[localNotification.userInfo objectForKey:@"type"] isEqualToString:@"DeveloperMichael"]) {
        [self handleNotificationWithType:[content objectForKey:@"type"] message:localNotification.alertBody msg:nil];
    }
}

/** 处理本地和远程通知 */
+ (void)handleNotificationWithType:(NSString *)type message:(NSString *)message msg:(NSDictionary *)msg {
    [self showNotificationViewType:type message:message msg:msg isBackground:NO];
}

/** 展示自定义横幅 */
+ (void)showNotificationViewType:(NSString *)type message:(NSString *)message msg:(NSDictionary *)msg isBackground:(BOOL)isBackground {
    [HandleNotificationView showNotificationViewWithContent:@"走到这里了" type:NotificationViewTypeLocalNotification didClick:^{
        NSLog(@"处理后的点击");
    }];
}

+ (void)handleRemoteNotificationWhenAppIsOnForegroundWithType:(NSString *)type aps:(NSDictionary *)aps msg:(NSDictionary *)msg {
    [self handleNotificationWithType:type message:nil msg:nil];
}

+ (void)handleRemoteNotificationWhenAppIsOnBackgroundOrInactiveWithType:(NSString *)type aps:(NSDictionary *)aps msg:(NSDictionary *)msg {
    [self handleNotificationWithType:type message:nil msg:nil];
}

#pragma mark-   移除所有自定义通知横幅
+ (void)cleanUpAllNotifications:(BOOL)animated {
    [HandleNotificationView hide:animated];
}


@end
