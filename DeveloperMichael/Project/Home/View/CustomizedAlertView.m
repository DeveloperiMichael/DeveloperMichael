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
@property (nonatomic, strong) CALayer *horizontalLine;
@property (nonatomic, strong) CALayer *verticalLine;
@end

@implementation CustomizedAlertView{
    
}

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kColorByRGB(255, 255, 255, 1);
        self.view_width = kScreenWidthRatio(280);
        self.view_height = kScreenHeightRatio(140);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        
        
        [self setupMaskPopups];
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

- (void)showAlertView {
    [_popups presentAnimated:YES completion:^(SnailQuickMaskPopups * _Nonnull popups) {
        
    }];
}

- (void)hideAlertView {
    [_popups dismissAnimated:YES completion:nil];
}


#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:20]];
        _titleLabel.text = @"Tips";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kColorByRGB(0, 0, 0, 1);
        //_titleLabel.backgroundColor = [UIColor yellowColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:15.0]];
        _contentLabel.text = @"[UIFont systemFontOfSize:[StringUtil GetFontSizeByScreenWidth:18]]";
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        //_contentLabel.backgroundColor = [UIColor brownColor];
        _contentLabel.textColor = kColorByRGB(176, 176, 176, 1);
    }
    return _contentLabel;
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
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(kScreenHeightRatio(7.5));
        //make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenWidthRatio(5));
        make.right.mas_equalTo(-kScreenWidthRatio(5));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(7.5);
        //make.height.mas_equalTo(kScreenHeightRatio(65));
    }];
    
    _horizontalLine = [CALayer layer];
    _horizontalLine.backgroundColor = kColorByRGB(252, 139, 107, 1).CGColor;
    _horizontalLine.top = _contentLabel.view_bottom;
    _horizontalLine.height = 0.5;
    _horizontalLine.width = self.view_width;
    [self.layer addSublayer:_horizontalLine];
    
    
    _verticalLine = [CALayer layer];
    _verticalLine.backgroundColor = kColorByRGB(252, 139, 107, 1).CGColor;
    _verticalLine.top = _horizontalLine.bottom;
    _verticalLine.centerX = self.view_centerX;
    _verticalLine.width = 0.5;
    [self.layer addSublayer:_verticalLine];
}


@end
