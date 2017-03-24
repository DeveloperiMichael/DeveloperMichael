//
//  TimerManagerObject.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/6.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TimerManagerObject : NSObject

+ (instancetype)shareTimerManagerInstance;

/**
 *  开始倒计时，如果倒计时管理器里具有相同的key，则直接开始回调。
 *
 *  @param aKey         任务key，用于标示唯一性
 *  @param timeInterval 倒计时总时间，受操作系统后台时间限制，倒计时时间规定不得大于 120 秒.
 *  @param countingDown 倒计时时，会多次回调，提供当前秒数
 *  @param finished     倒计时结束时调用，提供当前秒数，值恒为 0
 */
- (void)scheduledCountDownWithKey:(NSString *)aKey
                     timeInterval:(NSTimeInterval)timeInterval
                     countingDown:(nullable void (^)(NSTimeInterval leftTimeInterval))countingDown
                         finished:(nullable void (^)(__unused NSTimeInterval finalTimeInterval))finished;

/**
 *  查询倒计时任务是否存在
 *
 *  @param akey 任务key
 *  @param task 任务
 *  @return YES - 存在， NO - 不存在
 */
- (BOOL)countdownTaskExistWithKey:(NSString *)akey task:(NSOperation * _Nullable * _Nullable)task;

@property (nonatomic, strong) NSOperationQueue *pool;

@end

NS_ASSUME_NONNULL_END
