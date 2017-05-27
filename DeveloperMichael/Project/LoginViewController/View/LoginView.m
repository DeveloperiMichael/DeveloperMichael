//
//  LoginView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "LoginView.h"
#import "SAButton.h"
@interface LoginView ()

{
    NSInteger _limitNum;
}

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *wechatButton;
@property (nonatomic, strong) UILabel *qqLabel;
@property (nonatomic, strong) UILabel *wechatLabel;
@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UIView *rightLineView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *agreeLabel;
@property (nonatomic, strong) UIButton *agreeButton;

@end



@implementation LoginView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response

- (void)loginButtonPressed:(UIButton *)button {
    if ([_loginDelegate respondsToSelector:@selector(loginButtonClicked:)]) {
        [_loginDelegate loginButtonClicked:self];
    }
}

- (void)qqButtonPressed:(UIButton *)button {
    if ([_loginDelegate respondsToSelector:@selector(qqButtonClicked:)]) {
        [_loginDelegate qqButtonClicked:self];
    }
}

- (void)wechatButtonPressed:(UIButton *)button {
    if ([_loginDelegate respondsToSelector:@selector(wechatButtonClicked:)]) {
        [_loginDelegate wechatButtonClicked:self];
    }
}

- (void)vertifyCodeButtonPressed:(UIButton *)button {
    if ([_loginDelegate respondsToSelector:@selector(sendForVertifyCodeButtonClicked:)]) {
        [_loginDelegate sendForVertifyCodeButtonClicked:self];
    }
}

- (void)agreeButtonPressed:(UIButton *)button {
    if ([_loginDelegate respondsToSelector:@selector(agreeButtonClicked:)]) {
        [_loginDelegate agreeButtonClicked:self];
    }
}



#pragma mark-
#pragma mark- Private Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


- (void)textFieldDidChange:(UITextField *)textField{
    NSString *toBeString = textField.text;
    
    if (textField == _phoneTextFieldView.textField) {
        _limitNum = 11;
    }else if (textField == _passwordTextFieldView.textField){
        _limitNum = 6;
    }else{
        _limitNum = 20;
    }
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position||!selectedRange)
    {
        if (toBeString.length > _limitNum)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:_limitNum];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:_limitNum];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, _limitNum)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


#pragma mark-
#pragma mark- Getters && Setters

- (LoginTextFieldView *)phoneTextFieldView {
    if (!_phoneTextFieldView) {
        _phoneTextFieldView = [[LoginTextFieldView alloc] initWithTextFieldLeftIcon:@"login_iphone" placeholder:@"请输入有效的手机号"];
        _phoneTextFieldView.textField.keyboardType = UIKeyboardTypePhonePad;
        [_phoneTextFieldView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneTextFieldView;
}

- (LoginTextFieldView *)passwordTextFieldView {
    if (!_passwordTextFieldView) {
        _passwordTextFieldView = [[LoginTextFieldView alloc] initWithTextFieldLeftIcon:@"login_key" placeholder:@"请输入手机验证码"];
        _passwordTextFieldView.textField.keyboardType = UIKeyboardTypeNumberPad;
        [_passwordTextFieldView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextFieldView;
}

- (LoginTextFieldView *)inviteTextFieldView {
    if (!_inviteTextFieldView) {
        _inviteTextFieldView = [[LoginTextFieldView alloc] initWithTextFieldLeftIcon:@"login_iphone" placeholder:@"邀请人手机号或微信号"];
        [_inviteTextFieldView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inviteTextFieldView;
}

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    }
    return _logoImageView;
}

- (UIImageView *)lineImageView {
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_textview_line"]];
    }
    return _lineImageView;
}

- (UIButton *)vertifyCodeButton {
    if (!_vertifyCodeButton) {
        _vertifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _vertifyCodeButton.backgroundColor = [UIColor clearColor];
        [_vertifyCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_vertifyCodeButton setTitleColor:kColorByHex(0xff8291,1) forState:UIControlStateNormal];
        _vertifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:12.0]];
        [_vertifyCodeButton addTarget:self action:@selector(vertifyCodeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vertifyCodeButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:14.0]];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
        [_loginButton setTitleColor:kColorByHex(0xff8291,1) forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)qqButton {
    if (!_qqButton) {
        _qqButton = [SAButton buttonWithType:UIButtonTypeCustom];
        [_qqButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [_qqButton setTitle:@"QQ" forState:UIControlStateNormal];
        [_qqButton addTarget:self action:@selector(qqButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqButton;
}

- (UIButton *)wechatButton {
    if (!_wechatButton) {
        _wechatButton = [SAButton buttonWithType:UIButtonTypeCustom];
        [_wechatButton setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        [_wechatButton addTarget:self action:@selector(wechatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatButton;
}

- (UILabel *)qqLabel {
    if (!_qqLabel) {
        _qqLabel = [[UILabel alloc] init];
        _qqLabel.textAlignment = NSTextAlignmentCenter;
        _qqLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:10.0]];
        _qqLabel.textColor = [UIColor whiteColor];
        _qqLabel.text = @"QQ";
        _qqLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _qqLabel;
}

- (UILabel *)wechatLabel {
    if (!_wechatLabel) {
        _wechatLabel = [[UILabel alloc] init];
        _wechatLabel.textAlignment = NSTextAlignmentCenter;
        _wechatLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:10.0]];
        _wechatLabel.textColor = [UIColor whiteColor];
        _wechatLabel.text = @"微信";
        _wechatLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _wechatLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:10.0]];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"第三方登录";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIView *)leftLineView {
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = kColorByRGB(229, 229, 229, 0.1);
    }
    return _leftLineView;
}

- (UIView *)rightLineView {
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = kColorByRGB(229, 229, 229, 0.1);
    }
    return _rightLineView;
}

- (UILabel *)agreeLabel {
    if (!_agreeLabel) {
        _agreeLabel = [[UILabel alloc] init];
        _agreeLabel.textColor = [UIColor grayColor];
        _agreeLabel.text = @"我已同意WeMe";
        _agreeLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:12.0]];
    }
    return _agreeLabel;
}

- (UIButton *)agreeButton {
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeButton setTitleColor:kColorByHex(0xff8291,1) forState:UIControlStateNormal];
        _agreeButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:12.0]];
        [_agreeButton setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [_agreeButton addTarget:self action:@selector(agreeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.logoImageView];
    [self addSubview:self.phoneTextFieldView];
    [self addSubview:self.passwordTextFieldView];
    [self addSubview:self.inviteTextFieldView];
    [self addSubview:self.lineImageView];
    [self addSubview:self.vertifyCodeButton];
    [self addSubview:self.loginButton];
    [self addSubview:self.qqButton];
    [self addSubview:self.wechatButton];
    [self addSubview:self.wechatButton];
    [self addSubview:self.qqLabel];
    [self addSubview:self.wechatLabel];
    [self addSubview:self.tipLabel];
    [self addSubview:self.leftLineView];
    [self addSubview:self.rightLineView];
    [self addSubview:self.agreeLabel];
    [self addSubview:self.agreeButton];
    self.bgImageView.image = [UIImage imageNamed:@"login_bg.jpg"];
    self.navBarView.hidden = YES;
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBarView.mas_bottom).mas_offset(kScreenHeightRatio(25));
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(kScreenHeightRatio(75));
        make.height.mas_equalTo(kScreenHeightRatio(90));
    }];
    [_phoneTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(36));
        make.right.mas_equalTo(-kScreenWidthRatio(36));
        make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(kScreenHeightRatio(25));
        make.height.mas_equalTo(kScreenHeightRatio(36));
    }];
    [_passwordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(36));
        make.right.mas_equalTo(-kScreenWidthRatio(36));
        make.top.mas_equalTo(self.phoneTextFieldView.mas_bottom).mas_offset(kScreenHeightRatio(15));
        make.height.mas_equalTo(kScreenHeightRatio(36));
    }];
    [_inviteTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(36));
        make.right.mas_equalTo(-kScreenWidthRatio(36));
        make.top.mas_equalTo(self.passwordTextFieldView.mas_bottom).mas_offset(kScreenHeightRatio(15));
        make.height.mas_equalTo(kScreenHeightRatio(36));
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_passwordTextFieldView).mas_offset((kScreenWidth()-kScreenWidthRatio(72))*0.65);
        make.top.mas_equalTo(_passwordTextFieldView).mas_offset(kScreenHeightRatio(12));
        make.bottom.mas_equalTo(_passwordTextFieldView).mas_offset(-kScreenHeightRatio(12));
        make.width.mas_equalTo(1.0);
    }];
    [_vertifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lineImageView.mas_right);
        make.top.bottom.right.mas_equalTo(_passwordTextFieldView);
    }];
    [_passwordTextFieldView.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo((kScreenWidth()-kScreenWidthRatio(72))*0.65);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_phoneTextFieldView);
        make.top.mas_equalTo(_inviteTextFieldView.mas_bottom).mas_offset(kScreenHeightRatio(15));
        make.height.mas_equalTo(kScreenHeightRatio(30));
    }];
    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-kScreenHeightRatio(40));
        make.width.mas_equalTo(kScreenWidthRatio(40));
        make.height.mas_equalTo(kScreenWidthRatio(40));
        make.left.mas_equalTo((kScreenWidth()-kScreenWidthRatio(120))*0.5);
    }];
    [_qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_qqButton);
        make.top.mas_equalTo(_qqButton.mas_bottom);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    [_wechatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-kScreenHeightRatio(40));
        make.width.mas_equalTo(kScreenWidthRatio(40));
        make.height.mas_equalTo(kScreenWidthRatio(40));
        make.right.mas_equalTo(-(kScreenWidth()-kScreenWidthRatio(120))*0.5);
    }];
    [_wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_wechatButton);
        make.top.mas_equalTo(_wechatButton.mas_bottom);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_qqButton).mas_offset(-kScreenHeightRatio(30));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(15));
        make.right.mas_equalTo(_tipLabel.mas_left).mas_offset(-kScreenWidthRatio(15));
        make.centerY.mas_equalTo(_tipLabel);
        make.height.mas_equalTo(1);
    }];
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipLabel.mas_right).mas_offset(kScreenHeightRatio(15));
        make.right.mas_equalTo(self).mas_offset(-kScreenHeightRatio(15));
        make.centerY.mas_equalTo(_tipLabel);
        make.height.mas_equalTo(1);
    }];
    [_agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginButton.mas_bottom).mas_offset(kScreenHeightRatio(10));
        make.left.mas_equalTo((kScreenWidth()-[StringUtil widthForText:@"我已同意WeMe" textHeight:kScreenHeightRatio(20) font:12.0]-kScreenWidthRatio(80))*0.5);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_agreeLabel.mas_right);
        make.top.mas_equalTo(_agreeLabel);
        make.height.mas_equalTo(kScreenHeightRatio(20));
        make.width.mas_equalTo(kScreenWidthRatio(80));
    }];
}



@end
