//
//  AppDelegateViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/28.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "AppDelegateViewController.h"
#import "HandleNotificationObject.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "OrderViewController.h"
#import "MessageViewController.h"
#import "DailyLifeViewController.h"
#import "PrivateViewController.h"
#import "AdvertiseViewController.h"
#import "ImageAnimationViewController.h"
#import "BaseViewHeader.h"
@interface AppDelegateViewController ()

{
    UIWindow *mainWindow;
    UITabBarController *rootCtrl;
}

@end

@implementation AppDelegateViewController

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithWindow:(UIWindow *)window
            remoteNotification:(NSDictionary *)remoteInfo
             localNotification:(NSDictionary *)localInfo {
    self = [super init];
    if (self) {
        mainWindow = window;
        mainWindow.backgroundColor=[UIColor whiteColor];
        mainWindow.rootViewController=self;
        [self appIsKilledEnterWithRemoteNotification:remoteInfo localNotification:localInfo];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLoadImageAnimationViewController];
}


#pragma mark-
#pragma mark- Request



#pragma mark-
#pragma mark- Response


#pragma mark-
#pragma mark- delegate




#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

- (void)startLoadImageAnimationViewController {
    ImageAnimationViewController *animationCtrl=[[ImageAnimationViewController alloc] init];
    UINavigationController *animationNav=[[UINavigationController alloc] initWithRootViewController:animationCtrl];
    animationNav.navigationBarHidden = YES;
    mainWindow.rootViewController=animationNav;
    [mainWindow makeKeyAndVisible];
}


- (void)startLoadAdvertiseViewController {
    AdvertiseViewController *advertiseCtrl=[[AdvertiseViewController alloc] init];
    UINavigationController *advertiseNav=[[UINavigationController alloc] initWithRootViewController:advertiseCtrl];
    advertiseNav.navigationBarHidden = YES;
    mainWindow.rootViewController=advertiseNav;
    [mainWindow makeKeyAndVisible];
}

- (void)startLoadLoginViewController {
    LoginViewController *loginCtrl=[[LoginViewController alloc] init];
    UINavigationController *loginNav=[[UINavigationController alloc] initWithRootViewController:loginCtrl];
    loginNav.navigationBarHidden = YES;
    mainWindow.rootViewController=loginNav;
    [mainWindow makeKeyAndVisible];
}

- (void)startLoadHomeViewController {
    rootCtrl=[[UITabBarController alloc] init];
    rootCtrl.tabBar.backgroundImage=[UIImage imageNamed:@""];
    rootCtrl.tabBar.barStyle = UIBarStyleBlack;
    [rootCtrl.tabBar setTintColor:kColorByHex(0xff8291,1)];
    
    DailyLifeViewController *firstCtrl=[[DailyLifeViewController alloc] init];
    [firstCtrl.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    firstCtrl.tabBarItem.image=[UIImage imageNamed:@"daliylife"] ;
    firstCtrl.tabBarItem.title=@"动态";
    
    OrderViewController *secondCtrl=[[OrderViewController alloc] init];
    [secondCtrl.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    secondCtrl.tabBarItem.image=[UIImage imageNamed:@"tabBar_order"];
    secondCtrl.tabBarItem.title=@"订单";
    
    HomeViewController *thirdCtrl=[[HomeViewController alloc] init];
    thirdCtrl.tabBarItem.image=[UIImage imageNamed:@"tabBar_home"];
    thirdCtrl.tabBarItem.title=@"首页";
    [thirdCtrl.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    MessageViewController *fourthCtrl=[[MessageViewController alloc] init];
    fourthCtrl.tabBarItem.image=[UIImage imageNamed:@"message"];
    fourthCtrl.tabBarItem.title=@"消息";
    [fourthCtrl.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    PrivateViewController *fifthCtrl=[[PrivateViewController alloc] init];
    fifthCtrl.tabBarItem.image=[UIImage imageNamed:@"tabBar_mine"];
    fifthCtrl.tabBarItem.title=@"我的";
    [fifthCtrl.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    NSArray *tmpArr=@[firstCtrl,secondCtrl,thirdCtrl,fourthCtrl,fifthCtrl];
    for (BaseViewController *ctrl in tmpArr) {
        UINavigationController *itemNav=[[UINavigationController alloc] initWithRootViewController:ctrl];
        itemNav.navigationBarHidden = YES;
        [rootCtrl addChildViewController:itemNav];
    }
    
    mainWindow.rootViewController=rootCtrl;
    [mainWindow makeKeyAndVisible];
}

#pragma mark-  推送相关

/** 获得推送deviceToken */
- (void)controllerApplication:application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *deviceTokenStr =[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""];
    deviceTokenStr=[deviceTokenStr stringByReplacingOccurrencesOfString: @">" withString: @""];
    deviceTokenStr=[deviceTokenStr stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"deviceToken:%@",deviceTokenStr);
}

/** app killed 状态下推送点击事件 */
- (void)appIsKilledEnterWithRemoteNotification:(NSDictionary *)remoteInfo localNotification:(NSDictionary *)localInfo {
    //远程通知Kill点击事件处理
    if (remoteInfo) {
        NSLog(@"UIApplicationLaunchOptionsRemoteNotificationKey");
    }
    //本地通知Kill点击事件处理
    if (localInfo) {
        NSLog(@"UIApplicationLaunchOptionsLocalNotificationKey");
    }
}

/** app 非killed 状态下本地推送点击事件 */
- (void)controllerApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"%@", notification.userInfo);
    
    [HandleNotificationObject handleLocalNotificationWithLocalNotification:notification];
    
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"UIApplicationStateActive");
    }else if (application.applicationState == UIApplicationStateInactive){
        NSLog(@"UIApplicationStateInactive");
    }else if (application.applicationState == UIApplicationStateBackground){
        NSLog(@"UIApplicationStateBackground");
    }
}
 
/** app 非killed 状态下远程推送点击事件 */
- (void)controllerApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"userInfo(completionHandler)===%@",userInfo);
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"UIApplicationStateActive");
    }else if (application.applicationState == UIApplicationStateInactive){
        NSLog(@"UIApplicationStateInactive");
    }else if (application.applicationState == UIApplicationStateBackground){
        NSLog(@"UIApplicationStateBackground");
    }
}

#pragma mark-
#pragma mark- Getters && Setters




#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
