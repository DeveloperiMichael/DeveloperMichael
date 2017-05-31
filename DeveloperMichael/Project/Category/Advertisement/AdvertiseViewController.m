//
//  AdvertiseViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/7.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "AdvertiseViewController.h"
#import "LoginViewController.h"
#import "BaseView.h"

static NSInteger const kAdvertiseCountTime = 5;

@interface AdvertiseViewController ()
{
    NSInteger _countTime;
    BOOL _hasMoveNext;
}

@property (nonatomic, strong) BaseView *advertiseView;
@property (nonatomic, strong) UIButton *countButton;

@end

@implementation AdvertiseViewController


#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _countTime = kAdvertiseCountTime;
    [self setupSubviewsContraints];
    [self timeCount];
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




#pragma mark-
#pragma mark- Private Methods

-(UIImage *)advertiseImage
{
    //获取路径
    NSString * path = [[NSBundle mainBundle] pathForResource:@"AdvertiseImage" ofType:@"bundle"];
    int index = arc4random()%5+1;
    return [UIImage imageWithContentsOfFile:[[path stringByAppendingPathComponent:@"adsImage"] stringByAppendingPathComponent:[NSString stringWithFormat:@"ads%d.png",index]]];
    
}

//GCD倒计时
-(void)timeCount{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        _countTime--;
        if (_countTime == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _countTime = kAdvertiseCountTime;
                if (!_hasMoveNext) {
                    [self startLoadLoginViewController];
                }
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.countButton setTitle:[NSString stringWithFormat:@"跳过(%li)",(long)_countTime] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}

- (void)startLoadLoginViewController {
    _hasMoveNext = YES;
    LoginViewController *loginCtrl=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginCtrl animated:YES];
}

#pragma mark-
#pragma mark- Getters && Setters

- (BaseView *)advertiseView {
    if (!_advertiseView) {
        _advertiseView = [[BaseView alloc] init];
        _advertiseView.navBarView.hidden = YES;
        _advertiseView.bgImageView.image = [self advertiseImage];
    }
    return _advertiseView;
}

- (UIButton *)countButton {
    if (!_countButton) {
        _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _countButton.backgroundColor = kColorByRGB(0, 0, 0, 0.3);
        [_countButton setTitleColor:kColorByRGB(255, 255, 255, 1) forState:UIControlStateNormal];
        [_countButton addTarget:self action:@selector(startLoadLoginViewController) forControlEvents:UIControlEventTouchUpInside];
        _countButton.layer.masksToBounds = YES;
        _countButton.layer.cornerRadius = 4;
    }
    return _countButton;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.advertiseView];
    [self.view addSubview:self.countButton];
    [_advertiseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_countButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kScreenWidthRatio(15));
        make.top.mas_equalTo(kScreenHeightRatio(30));
        make.width.mas_equalTo(kScreenWidthRatio(66));
        make.height.mas_equalTo(kScreenWidthRatio(30));
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
