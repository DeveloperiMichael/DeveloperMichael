//
//  SharedViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/28.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "SharedViewController.h"


@interface SharedViewController ()



@end

@implementation SharedViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.sharedView show];
}

- (SharedStyleView *)sharedView {
    if (!_sharedView) {
        _sharedView = [[SharedStyleView alloc] init];
    }
    return _sharedView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"-------------");
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
