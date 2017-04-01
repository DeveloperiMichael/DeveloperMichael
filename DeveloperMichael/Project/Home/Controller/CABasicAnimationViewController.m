//
//  CABasicAnimationViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CABasicAnimationViewController.h"
#import "CABasicAnimationView.h"

@interface CABasicAnimationViewController ()<BaseViewDelegate>

@property (nonatomic, strong) CABasicAnimationView *basicAnimationView;

@end

@implementation CABasicAnimationViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviewsContraints];
}


/*
 timingFunction  匀速  加速
 
 
 */

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
    [self beginAnimation];
}

- (void)leftButtonClicked:(BaseView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- Private Methods

- (void)beginAnimation {
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:1.5];
    animation.autoreverses=YES;
    animation.duration=0.5;
    animation.repeatCount=1;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;

    
    [_basicAnimationView.animationView.layer addAnimation:animation forKey:@"transform.scale"];
}


#pragma mark-
#pragma mark- Getters && Setters

- (CABasicAnimationView *)basicAnimationView {
    if (!_basicAnimationView) {
        _basicAnimationView = [[CABasicAnimationView alloc] init];
        _basicAnimationView.titleLabel.text = self.navigationBarTitle;
        _basicAnimationView.delegate = self;
    }
    return _basicAnimationView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.basicAnimationView];
    [_basicAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
