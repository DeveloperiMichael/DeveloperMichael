//
//  TimerManagerTask.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/6.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerManagerTask : NSOperation

/**
 *  计时中回调
 */
@property (copy, nonatomic) void (^countingDownBlcok)(NSTimeInterval timeInterval);
/**
 *  计时结束后回调
 */
@property (copy, nonatomic) void (^finishedBlcok)(NSTimeInterval timeInterval);
/**
 *  计时剩余时间
 */
@property (assign, nonatomic) NSTimeInterval leftTimeInterval;
/**
 *  后台任务标识，确保程序进入后台依然能够计时
 */
@property (assign, nonatomic) UIBackgroundTaskIdentifier taskIdentifier;

@end
