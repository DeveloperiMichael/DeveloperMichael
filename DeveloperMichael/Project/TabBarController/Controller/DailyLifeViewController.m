//
//  DailyLifeViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/7.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DailyLifeViewController.h"
#import "PublishViewController.h"
#import "DaliyLifeView.h"

@interface DailyLifeViewController ()<BaseViewDelegate>

@property (nonatomic, strong) DaliyLifeView *lifeView;

@end

@implementation DailyLifeViewController



#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
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
    PublishViewController *vc = [[PublishViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (DaliyLifeView *)lifeView {
    if (!_lifeView) {
        _lifeView = [[DaliyLifeView alloc] init];
        _lifeView.delegate = self;
    }
    return _lifeView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.lifeView];
    [_lifeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
