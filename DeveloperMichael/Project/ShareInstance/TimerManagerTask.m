//
//  TimerManagerTask.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/6.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "TimerManagerTask.h"

@implementation TimerManagerTask

- (void)main {
    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    while (--_leftTimeInterval > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_countingDownBlcok) _countingDownBlcok(_leftTimeInterval);
        });
        
        [NSThread sleepForTimeInterval:1];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_finishedBlcok) {
            _finishedBlcok(0);
        }
    });
    
    if (self.taskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.taskIdentifier];
        self.taskIdentifier = UIBackgroundTaskInvalid;
    }
}

@end
