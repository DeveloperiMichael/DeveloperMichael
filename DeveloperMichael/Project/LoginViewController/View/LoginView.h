//
//  LoginView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"
#import "LoginTextFieldView.h"

@class LoginView;

@protocol LoginViewDelegate <NSObject>

- (void)sendForVertifyCodeButtonClicked:(LoginView *)loginView;
- (void)loginButtonClicked:(LoginView *)loginView;
- (void)agreeButtonClicked:(LoginView *)loginView;
- (void)qqButtonClicked:(LoginView *)loginView;
- (void)wechatButtonClicked:(LoginView *)loginView;

@end

@interface LoginView : BaseView

@property (nonatomic, strong) LoginTextFieldView *phoneTextFieldView;
@property (nonatomic, strong) LoginTextFieldView *passwordTextFieldView;
@property (nonatomic, strong) LoginTextFieldView *inviteTextFieldView;
@property (nonatomic, strong) UIButton *vertifyCodeButton;
@property (nonatomic, weak) id<LoginViewDelegate> loginDelegate;

@end
