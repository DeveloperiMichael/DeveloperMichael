//
//  BaseViewController.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/28.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/** 是否需要返回某个界面的方法 */

@property (nonatomic, copy) NSString *navigationBarTitle;

/** 如果有长连接 */
- (void)socketResponseWithContent:(NSDictionary *)content userId:(NSString *)userId fromSource:(NSString *)fromSource;
- (void)showHUDForWaitSocketData;
- (void)hideHUDForWaitSocketData;


@end
