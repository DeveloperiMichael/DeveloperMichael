//
//  CustomizedAlertView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/26.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CustomizedAlertView.h"
#import "SnailQuickMaskPopups.h"
#import "BaseViewHeader.h"
@interface CustomizedAlertView()

@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *horizontalLine;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, copy) CustomizedAlertBlock leftBlock;
@property (nonatomic, copy) CustomizedAlertBlock rightBlock;

@end

@implementation CustomizedAlertView{
    NSString *_title;
    NSString *_content;
    NSString *_leftButtonTitle;
    NSString *_rightButtonTitle;
}

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)content
              leftButtonTitle:(NSString *)leftTitle
              leftButtonBlock:(CustomizedAlertBlock)leftBlock
             rightButtonTitle:(NSString *)rightTitle
             rightButtonBlock:(CustomizedAlertBlock)rightBlock{
    self = [super init];
    if (self) {
        [self initializationDefaultData];
        
        _title = title;
        _content = content;
        _leftButtonTitle = leftTitle;
        _rightButtonTitle = rightTitle;
        self.leftBlock = leftBlock;
        self.rightBlock = rightBlock;
        
        [self setupMaskPopups];
        [self setupSubviewsContraints];
        
    }
    return self;
}

#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response

- (void)leftButtonPressed:(UIButton *)button {
    [_popups dismissAnimated:YES completion:nil];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightButtonPressed:(UIButton *)button {
    [_popups dismissAnimated:YES completion:nil];
    if (self.rightBlock) {
        self.rightBlock();
    }
}


#pragma mark-
#pragma mark- Private Methods

- (void)initializationDefaultData {
    self.backgroundColor = kColorByRGB(255, 255, 255, 1);
    self.view_width = 280;
    self.view_height = 140;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
    
    _title = @"Tips";
    _content = @"Warning: please enter your content";
    _leftButtonTitle = @"Cancel";
    _rightButtonTitle = @"Sure";
}

- (void)presentAlertViewAnimated:(BOOL)animated completion:(CustomizedAlertBlock)completion {
    [_popups presentAnimated:animated completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        if (completion) {
            completion();
        }
    }];
}

- (void)dismissAlertViewAnimated:(BOOL)animated completion:(CustomizedAlertBlock)completion {
    [_popups dismissAnimated:animated completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        if (completion) {
            completion();
        }
    }];
}


#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:17.0]];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kColorByRGB(0, 0, 0, 1);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:16.0]];
        _contentLabel.text = _content;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = kColorByRGB(176, 176, 176, 1);
    }
    return _contentLabel;
}

- (UIView *)horizontalLine {
    if (!_horizontalLine) {
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = kColorByRGB(252, 139, 107, 1);
    }
    return _horizontalLine;
}

- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = kColorByRGB(252, 139, 107, 1);
    }
    return _verticalLine;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitleColor:kColorByRGB(252, 109, 54, 1) forState:UIControlStateNormal];
        [_leftButton setTitle:_leftButtonTitle forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:17.0]];
        [_leftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:kColorByRGB(252, 109, 54, 1) forState:UIControlStateNormal];
        [_rightButton setTitle:_rightButtonTitle forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:17.0]];
        [_rightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupMaskPopups {
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackBlur aView:self];
    _popups.presentationStyle = PresentationStyleCentered;
    _popups.transitionStyle = TransitionStyleFromTop;
    _popups.isDismissedOppositeDirection = YES;
    _popups.isAllowMaskTouch = YES;
    _popups.dampingRatio = 0.5;
}

- (void)setupSubviewsContraints{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.horizontalLine];
    [self addSubview:self.verticalLine];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(12.5);
        make.height.mas_equalTo(20);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(7.5);
        make.height.mas_equalTo(55);
    }];
    [_horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_contentLabel.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horizontalLine.mas_bottom);
        make.bottom.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(1 );
    }];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horizontalLine.mas_bottom);
        make.left.bottom.mas_equalTo(self);
        make.right.mas_equalTo(_verticalLine.mas_left);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_horizontalLine.mas_bottom);
        make.right.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_verticalLine.mas_right);
    }];
}


@end
