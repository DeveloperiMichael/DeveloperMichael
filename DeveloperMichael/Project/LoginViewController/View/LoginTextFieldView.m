//
//  LoginTextFieldView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "LoginTextFieldView.h"
#import "BaseViewHeader.h"

@interface LoginTextFieldView ()

/** icon name */
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation LoginTextFieldView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithTextFieldLeftIcon:(NSString *)iconName placeholder:(NSString *)placeholder {
    self = [super init];
    if (self) {
        _iconName = iconName;
        _placeholder = placeholder;
        [self setupSubviewsContraints];
    }
    return self;
}


#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response





#pragma mark-
#pragma mark- Private Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (UITextField *)textFieldWithLeftIcon:(NSString *)leftIcon placeholder:(NSString *)placeholder

{
    UIImageView *leftView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:leftIcon]];
    leftView.view_left = kScreenWidthRatio(10);
    leftView.view_width = kScreenWidthRatio(16);
    leftView.view_height = kScreenWidthRatio(16);
    
    UITextField *textField = [[UITextField alloc]initWithFrame:self.frame];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 5;
    textField.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:12.0]];;
    textField.textColor = [UIColor whiteColor];
    textField.tintColor = kColorByRGB(94, 94, 94, 1);
    
    UIView *leftViewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, leftView.view_width + kScreenWidthRatio(20), textField.view_height)];
    [leftViewBG addSubview:leftView];
    leftView.view_top = (leftViewBG.view_height - leftView.view_height) * 0.5;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftViewBG;
    textField.placeholder = placeholder;
    [textField setValue:kColorByRGB(94, 94, 94, 1) forKeyPath:@"_placeholderLabel.textColor"];
    
    return textField;
}




#pragma mark-
#pragma mark- Getters && Setters

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.cornerRadius = kScreenHeightRatio(36)*0.5;
        _bgImageView.backgroundColor = kColorByRGB(0, 0, 0, 0.1);
        
    }
    return _bgImageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [self textFieldWithLeftIcon:_iconName placeholder:_placeholder];
    }
    return _textField;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.bgImageView];
    [self addSubview:self.textField];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


@end
