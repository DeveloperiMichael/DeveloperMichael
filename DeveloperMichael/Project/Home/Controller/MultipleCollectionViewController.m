//
//  AnimationViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "MultipleCollectionViewController.h"
#import "WaterfallCollectionViewController.h"
#import "HomeView.h"

@interface MultipleCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,BaseViewDelegate>

@property (nonatomic, strong) HomeView *MultipleCollectionView;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation MultipleCollectionViewController

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
    
    BaseViewController *vc;
    
    switch (indexPath.row) {
        case 0:
        {
            vc = [[WaterfallCollectionViewController alloc] init];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        default:
            break;
    }
    
    if (vc) {
        vc.navigationBarTitle = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark-
#pragma mark- Event response

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClicked:(BaseView *)view {
    
}


#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (HomeView *)MultipleCollectionView {
    if (!_MultipleCollectionView) {
        _MultipleCollectionView = [[HomeView alloc] init];
        _MultipleCollectionView.delegate = self;
        _smallAnimalView.homeTableView.delegate = self;
        _smallAnimalView.homeTableView.dataSource = self;
        _smallAnimalView.titleLabel.text = self.navigationBarTitle;
    }
    return _MultipleCollectionView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"WaterfallCollectionView", nil];
    }
    return _titleArray;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.smallAnimalView];
    [_MultipleCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
