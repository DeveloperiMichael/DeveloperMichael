//
//  PageCollectionViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/21.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PageCollectionViewController.h"
#import "PageCollectionView.h"

@interface PageCollectionViewController ()<BaseViewDelegate>

@property (nonatomic, strong) PageCollectionView *pageCollectionView;

@end

@implementation PageCollectionViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
}

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (PageCollectionView *)pageCollectionView {
    if (!_pageCollectionView) {
        _pageCollectionView = [[PageCollectionView alloc] init];
        _pageCollectionView.delegate = self;
        _pageCollectionView.titleLabel.text = self.navigationBarTitle;
    }
    return _pageCollectionView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.pageCollectionView];
    [_pageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


@end
