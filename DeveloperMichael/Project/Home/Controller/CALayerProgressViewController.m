//
//  CALayerProgressViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/1.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CALayerProgressViewController.h"
#import "CALayerProgressView.h"


@interface CALayerProgressViewController ()<BaseViewDelegate>

@property (nonatomic, strong) CALayerProgressView *layerProgressView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CALayerProgressViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressTimer:) userInfo:nil repeats:YES];
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- Request

- (void)progressTimer:(NSTimer *)timer
{
    self.layerProgressView.circleProgress.progressPercent += 0.01;
    self.layerProgressView.circleProgress.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.layerProgressView.circleProgress.progressPercent*100];
    
    self.layerProgressView.antiCircleProgress.progressPercent += 0.01;
    
    self.layerProgressView.noWaveProgressView.percent += 0.01;
    self.layerProgressView.noWaveProgressView.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.layerProgressView.noWaveProgressView.percent*100];
    
    self.layerProgressView.waveProgressView.percent += 0.01;
    self.layerProgressView.waveProgressView.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.layerProgressView.waveProgressView.percent*100];

    
    if(self.layerProgressView.circleProgress.progressPercent >= 1)
    {
        self.layerProgressView.circleProgress.progressPercent = 0;
        self.layerProgressView.antiCircleProgress.progressPercent = 0;
        self.layerProgressView.waveProgressView.percent = 0;
        self.layerProgressView.noWaveProgressView.percent = 0;
    }
    
    
}



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

- (CALayerProgressView *)layerProgressView {
    if (!_layerProgressView) {
        _layerProgressView = [[CALayerProgressView alloc] init];
        _layerProgressView.delegate = self;
        _layerProgressView.titleLabel.text = self.navigationBarTitle;
    }
    return _layerProgressView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.layerProgressView];
    [_layerProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
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
