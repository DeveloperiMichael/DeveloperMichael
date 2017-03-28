//
//  HomeViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "AnimationViewController.h"
#import "TimerManagerObject.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) HomeView *homeView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation HomeViewController


#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviewsContraints];
    
}



#pragma mark-
#pragma mark- Request



#pragma mark-
#pragma mark- SANetworkResponseProtocol



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
            make.top.mas_equalTo(49.5);
            make.height.mas_equalTo(0.5);
        }];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AnimationViewController *vc = [[AnimationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark-
#pragma mark- Event response



#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (HomeView *)homeView {
    if (!_homeView) {
        _homeView = [[HomeView alloc] init];
        _homeView.homeTableView.delegate = self;
        _homeView.homeTableView.dataSource = self;
    }
    return _homeView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"UIKeyAnimationType", nil];
    }
    return _titleArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.homeView];
    [_homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
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
