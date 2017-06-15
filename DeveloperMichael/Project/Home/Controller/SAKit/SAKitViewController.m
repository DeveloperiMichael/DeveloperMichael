//
//  SAKitViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 2017/6/15.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "SAKitViewController.h"
#import "SAKitView.h"
#import "SALoadingHUDAccessory.h"

@interface SAKitViewController ()<BaseViewDelegate>

@property (nonatomic, strong) SAKitView *kitView;

@end

@implementation SAKitViewController


#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    SALoadingHUDAccessory *accessory = [[SALoadingHUDAccessory alloc] initWithShowInView:self.view withText:@""];
    [accessory startLoadingAnimation];
    
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- SACardViewDataSource




#pragma mark-
#pragma mark- delegate




#pragma mark-
#pragma mark- Event response

- (void)rightButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (SAKitView *)kitView {
    if (!_kitView) {
        _kitView = [[SAKitView alloc] init];
        _kitView.delegate = self;
        _kitView.titleLabel.text = self.navigationBarTitle;
    }
    return _kitView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.kitView];
    [_kitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
