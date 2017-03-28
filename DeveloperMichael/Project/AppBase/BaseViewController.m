//
//  BaseViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/28.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewHeader.h"
#import "DailyLifeViewController.h"
#import "OrderViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "PrivateViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
//    self.edgesForExtendedLayout=UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars=NO;
    self.modalPresentationCapturesStatusBarAppearance=NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //注册截屏通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification
                                               object:nil];
    
    //如果不是tabBar上的controller隐藏tabBar
    if ([self isKindOfClass:[DailyLifeViewController class]]||[self isKindOfClass:[OrderViewController class]]||[self isKindOfClass:[HomeViewController class]]||[self isKindOfClass:[MessageViewController class]]||[self isKindOfClass:[PrivateViewController class]]) {
        self.tabBarController.tabBar.hidden=NO;
    }else{
        self.tabBarController.tabBar.hidden=YES;
    }
}

#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response


#pragma mark-
#pragma mark- delegate




#pragma mark-
#pragma mark- Event response

//截屏响应
- (void)userDidTakeScreenshot:(NSNotification *)notification {
    [self performSelector:@selector(showNotification) withObject:nil afterDelay:0.5];
}


#pragma mark-
#pragma mark- Private Methods

- (void)showNotification {
//    [SANotificationView showNotificationViewWithContent:NSLocalizedString(@"已截屏，是要吐槽么？", nil) type:SANotificationViewTypeScreenShots didClick:nil];
}


#pragma mark-
#pragma mark- Getters && Setters




#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    
}



- (void)dealloc {
    NSLog(@"--dealloc--<类 /** %@ **/ 已释放>",NSStringFromClass([self class]));
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
