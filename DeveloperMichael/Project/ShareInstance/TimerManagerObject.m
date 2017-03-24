//
//  TimerManagerObject.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/6.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "TimerManagerObject.h"
#import "TimerManagerTask.h"
@implementation TimerManagerObject

+ (instancetype)shareTimerManagerInstance {
    static TimerManagerObject *timerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[TimerManagerObject alloc] init];
    });
    return timerManager;
}

- (void)scheduledCountDownWithKey:(NSString *)aKey
                     timeInterval:(NSTimeInterval)timeInterval
                     countingDown:(void (^)(NSTimeInterval))countingDown
                         finished:(void (^)(NSTimeInterval))finished
{
    if (timeInterval > 600) {
        NSCAssert(NO, @"受操作系统后台时间限制，倒计时时间规定不得大于 600 秒.");
    }
    
    self.pool.maxConcurrentOperationCount = 20;
    if (self.pool.operations.count >= 20)  // 最多 20 个并发线程
        return;
    
    TimerManagerTask *task;
    if ([self countdownTaskExistWithKey:aKey task:&task]) {
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        if (countingDown) {
            countingDown(task.leftTimeInterval);
        }
    } else {
        task                   = [[TimerManagerTask alloc] init];
        task.name              = aKey;
        task.leftTimeInterval  = timeInterval;
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        [self.pool addOperation:task];
    }
}

- (NSOperationQueue *)pool {
    if (!_pool) {
        _pool = [[NSOperationQueue alloc] init];
    }
    return _pool;
}

- (BOOL)countdownTaskExistWithKey:(NSString *)akey
                            task:(NSOperation *__autoreleasing  _Nullable *)task
{
    __block BOOL taskExist = NO;
    [self.pool.operations enumerateObjectsUsingBlock:^(__kindof NSOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:akey]) {
            if (task) *task = obj;
            taskExist = YES;
            *stop     = YES;
        }
    }];
    
    return taskExist;
}


@end
