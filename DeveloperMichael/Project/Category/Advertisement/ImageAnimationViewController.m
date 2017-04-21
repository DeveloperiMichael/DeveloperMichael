//
//  ImageAnimationViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/7.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "ImageAnimationViewController.h"
#import "BaseViewHeader.h"
#import "AdvertiseViewController.h"

static float const kAnimationDuration = 3.5;

@interface ImageAnimationViewController ()

@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation ImageAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareAnimationImage];
    [self setupSubviewsContraints];
    [_animationImageView startAnimating];
    
    CGFloat fadeDuration = 0.5;
    [UIView animateWithDuration:fadeDuration delay:kAnimationDuration options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.animationImageView.alpha = 0.1;
        self.animationImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [_animationImageView stopAnimating];
        AdvertiseViewController *vc = [[AdvertiseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark-
#pragma mark- View Life Cycle




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

- (void)prepareAnimationImage {
    NSInteger imageCount = 80;
    for (int i=1; i<imageCount; i++) {
        //NSString *imageName = [NSString stringWithFormat:@"BootAnimation%d",i];
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"BootAnimation%d",i] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [self.imageArray addObject:image];
    }
}



#pragma mark-
#pragma mark- Getters && Setters

- (UIImageView *)animationImageView {
    if (!_animationImageView) {
        _animationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BootAnimation80.png"]];
        _animationImageView.animationDuration = kAnimationDuration;
        _animationImageView.animationImages = _imageArray;
        _animationImageView.animationRepeatCount = 1;
    }
    return _animationImageView;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}



#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.animationImageView];
    [self.animationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(kScreenHeightRatio(175));
        make.width.mas_equalTo(kScreenWidthRatio(180));
        make.height.mas_equalTo(kScreenWidthRatio(180));
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
