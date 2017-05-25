//
//  CalendarViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/5/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"
#import "CalendarCollectionViewCell.h"
#import "XZMRefresh.h"
@interface CalendarViewController ()<BaseViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) CalendarView *calendarView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSDate *currentPageDate;

@end

@implementation CalendarViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dateArray = [NSMutableArray array];
    _currentPageDate = [NSDate date];
    [_dateArray addObjectsFromArray:[self monthDatesWithDate:_currentPageDate]];
    
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag==100) {
        return 1;
    }else{
        return 7;
    }

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dateArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (collectionView.tag) {
        case 100:
        {
            CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCollectionViewCell" forIndexPath:indexPath];
            NSDate *date = [DateUtil dateFromString:_dateArray[indexPath.section] withDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [DateUtil stringFromDate:date withDateFormat:@"MM-dd"];
            NSString *weekString = [DateUtil weekdayStringFromDate:date];
            cell.title = [NSString stringWithFormat:@"%@///%@",dateString,weekString];
            cell.backgroundColor = kRandomColor;
            return cell;
        }
            break;
        case 200:
        {
           UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCollectionViewCell" forIndexPath:indexPath];
            cell.backgroundColor = kRandomColor;
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
   
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

- (NSMutableArray *)monthDatesWithDate:(NSDate *)date {
    NSInteger days = [DateUtil numberOfDaysInMonthWithDate:date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 1; i<days+1; i++) {
        [array addObject:[NSString stringWithFormat:@"%li-%li-%li",(long)year,month,i]];
    }
    return array;
}


#pragma mark-
#pragma mark- Getters && Setters

- (CalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[CalendarView alloc] init];
        _calendarView.delegate = self;
        _calendarView.calendarContentView.contentCollectionView.delegate = self;
        _calendarView.calendarContentView.contentCollectionView.dataSource = self;
        [_calendarView.calendarContentView.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ContentCollectionViewCell"];
        _calendarView.calendarContentView.calendarCollectionView.delegate = self;
        _calendarView.calendarContentView.calendarCollectionView.dataSource = self;
        [_calendarView.calendarContentView.calendarCollectionView registerClass:[CalendarCollectionViewCell class] forCellWithReuseIdentifier:@"CalendarCollectionViewCell"];
        
        
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
