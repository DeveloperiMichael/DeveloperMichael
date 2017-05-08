//
//  CalendarViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/5/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"

@interface CalendarViewController ()<BaseViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) CalendarView *calendarView;

@end

@implementation CalendarViewController

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
#pragma mark- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-----%ld----",indexPath.row);
}

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

- (CalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[CalendarView alloc] init];
        _calendarView.delegate = self;
        _calendarView.calendarContentView.contentCollectionView.delegate = self;
        _calendarView.calendarContentView.contentCollectionView.dataSource = self;
        [_calendarView.calendarContentView.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"contentCollectionViewCell"];
    }
    return _calendarView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.calendarView];
    [_calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
