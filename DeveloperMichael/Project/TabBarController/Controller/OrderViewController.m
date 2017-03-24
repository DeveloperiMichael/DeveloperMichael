//
//  OrderViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/7.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "OrderViewController.h"
#import "MBProgressHUD.h"

@interface OrderViewController ()

@property (nonatomic, strong) MBProgressHUD *successHud;
@property (nonatomic, strong) UIView *hudView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    //[self.successHud show:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 设置图片
    UIView *successView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 132, 207)];
    hud.customView = successView;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
   
    [hud show:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MBProgressHUD *)successHud {
    if (!_successHud) {
        _successHud = [[MBProgressHUD alloc] initWithView:self.view];
        _successHud.mode = MBProgressHUDModeCustomView;
        _successHud.customView = self.hudView;
        [self.view addSubview:_successHud];
    }
    return _successHud;
}

- (UIView *)hudView {
    if (!_hudView) {
        _hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _hudView.backgroundColor = [UIColor redColor];
    }
    return _hudView;
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
