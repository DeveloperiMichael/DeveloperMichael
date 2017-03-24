//
//  HandleNotificationView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HandleNotificationView;

typedef NS_ENUM(NSInteger, NotificationViewType) {
    NotificationViewTypeLocalNotification,
    NotificationViewTypeScreenShots,
    NotificationViewTypeTopHUDNormal,
    NotificationViewTypeTopHUDWarning
};


/** HandleNotificationView 管理 */
@interface NotificationManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray <HandleNotificationView *>*notificationViewList;
+ (instancetype)sharedInstance;

@end


/** 展示通知 */
@interface HandleNotificationView : UIScrollView

+ (void)showTopNormalHUDWithContent:(NSString *)content;
+ (void)showTopWarningHUDWithContent:(NSString *)content;
+ (void)showNotificationViewWithContent:(NSString *)content type:(NotificationViewType)type didClick:(void(^)())didClick;
+ (void)hide:(BOOL)animate;

@end
