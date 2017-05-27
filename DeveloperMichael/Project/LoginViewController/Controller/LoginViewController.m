//
//  LoginViewController.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "AppDelegate.h"
static NSInteger const kResetVertifyCodeTime = 60;

@interface LoginViewController ()<LoginViewDelegate>

{
    NSInteger _countTime;
}

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginViewController



#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _countTime = kResetVertifyCodeTime;
    [self setupSubviewsContraints];
}


#pragma mark-
#pragma mark- Request




#pragma mark-
#pragma mark- Response



#pragma mark-
#pragma mark- delegate

#pragma mark- <LoginViewDelegate>

- (void)qqButtonClicked:(LoginView *)loginView {
    [self.view endEditing:YES];
}

- (void)wechatButtonClicked:(LoginView *)loginView {
    [self.view endEditing:YES];
}

- (void)loginButtonClicked:(LoginView *)loginView {
    [self.view endEditing:YES];
    [appDelegate.appDelegateCtrl startLoadHomeViewController];
}

- (void)sendForVertifyCodeButtonClicked:(LoginView *)loginView {
    [self.view endEditing:YES];
    if ([StringUtil isStringType:StringPhoneType checkString:_loginView.phoneTextFieldView.textField.text]) {
        [self timeCount];
    }else{
        [self showHint:@"手机号格式错误，请重新输入" Position:0 afterDelay:2.0];
    }
}

- (void)agreeButtonClicked:(LoginView *)loginView {
    [self.view endEditing:YES];
    [self showHint:@"暂无用户协议" Position:0 afterDelay:2.0];
}


#pragma mark-
#pragma mark- Event response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


#pragma mark-
#pragma mark- Private Methods

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
                _countTime = kResetVertifyCodeTime;
                _loginView.vertifyCodeButton.userInteractionEnabled = YES;
                [_loginView.vertifyCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                _loginView.vertifyCodeButton.userInteractionEnabled = NO;
                [_loginView.vertifyCodeButton setTitle:[NSString stringWithFormat:@"%li秒后重新获取",(long)_countTime] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}



#pragma mark-
#pragma mark- Getters && Setters

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
        _loginView.loginDelegate = self;
    }
    return _loginView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.view addSubview:self.loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
