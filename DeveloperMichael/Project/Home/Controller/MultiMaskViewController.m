//
//  MultiMaskViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/26.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "MultiMaskViewController.h"
#import "HomeView.h"
#import "CustomizedAlertView.h"
#import "SnailQuickMaskPopups.h"
@interface MultiMaskViewController ()<BaseViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HomeView *multiMaskView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation MultiMaskViewController

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

#pragma mark-  <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorByRGB(153, 153, 153, 0.5);
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenWidthRatio(12));
            make.right.mas_equalTo(-kScreenWidthRatio(12));
            make.top.mas_equalTo(43.5);
            make.height.mas_equalTo(0.5);
        }];
        UIImageView *next = [[UIImageView alloc] init];
        next.image = [UIImage imageNamed:@"next"];
        [cell.contentView addSubview:next];
        [next mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(14);
            make.right.mas_equalTo(-kScreenWidthRatio(12));
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomizedAlertView *view = [[CustomizedAlertView alloc] init];
    [view showAlertView];
}



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

- (HomeView *)multiMaskView {
    if (!_multiMaskView) {
        _multiMaskView = [[HomeView alloc] init];
        _multiMaskView.delegate = self;
        _multiMaskView.homeTableView.delegate = self;
        _multiMaskView.homeTableView.dataSource = self;
        _multiMaskView.titleLabel.text = self.navigationBarTitle;
    }
    return _multiMaskView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"Alert Style",@"WeChat Style",@"Qzone Style",@"Shared Style",@"SlideBar Style",@"Full Style", nil];
    }
    return _titleArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.multiMaskView];
    [_multiMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
