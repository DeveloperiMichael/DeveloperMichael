//
//  SALoadingHUDAccessory.m
//  DeveloperMichael
//
//  Created by 张炯 on 2017/6/15.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "SALoadingHUDAccessory.h"
#import "LoadProgressView.h"
#import "SANetworkAccessoryProtocol.h"
@interface SALoadingHUDAccessory()<SANetworkAccessoryProtocol>

@property (nonatomic, strong) LoadProgressView *loadingView;

@end

@implementation SALoadingHUDAccessory

- (instancetype)initWithShowInView:(UIView *)view withText:(NSString *)string {
    self = [super init];
    if (self) {
        _loadingView = [[LoadProgressView alloc] initWithShowInView:view withText:string];
        _loadingView.hidden = YES;
        [view addSubview:_loadingView];
        
    }
    return self;
}

- (void)networkRequestAccessoryWillStart {
    [self stopLoadingAnimation];
}


- (void)networkRequestAccessoryDidStop {
    [self stopLoadingAnimation];
}

- (void)startLoadingAnimation {
    _loadingView.hidden = NO;
}

- (void)stopLoadingAnimation {
    [_loadingView removeFromSuperview];
    _loadingView = nil;
}

@end
