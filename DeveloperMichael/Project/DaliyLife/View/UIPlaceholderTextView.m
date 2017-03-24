//
//  PlaceholderTextView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "UIPlaceholderTextView.h"
#import "BaseViewHeader.h"


@interface UIPlaceholderTextView ()<UITextViewDelegate>

{
    float kCollectionImageLength;
}

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *characterLabel;

@end

@implementation UIPlaceholderTextView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        kCollectionImageLength = (kScreenWidth()-kScreenWidthRatio(5)*5)/4;
        _limitCharacter = 200;
        [self setupSubviewsContraints];
    }
    return self;
}

#pragma mark-
#pragma mark- <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length>_limitCharacter) {
        textView.text = [textView.text substringToIndex:_limitCharacter];
    }
    _characterLabel.text = [NSString stringWithFormat:@"%li/%li",(unsigned long)textView.text.length,(long)_limitCharacter];
}



#pragma mark-
#pragma mark- Event response





#pragma mark-
#pragma mark- Private Methods





#pragma mark-
#pragma mark- Getters && Setters

- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.delegate = self;
        _contentTextView.backgroundColor = [UIColor clearColor];
        [_contentTextView addSubview:self.placeHolderLabel];
        _contentTextView.font = [UIFont systemFontOfSize:13.0];
        _placeHolderLabel.font = [UIFont systemFontOfSize:13.0];
        [_contentTextView setValue:_placeHolderLabel forKey:@"_placeholderLabel"];
    }
    return _contentTextView;
}

- (void)setLimitCharacter:(NSInteger)limitCharacter {
    _limitCharacter = limitCharacter;
    _characterLabel.text = [NSString stringWithFormat:@"0/%li",(long)_limitCharacter];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeHolderLabel.text = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeHolderLabel.textColor = placeholderColor;
}

- (void)setText:(NSString *)text {
    _contentTextView.text = text;
}

- (NSString *)text {
    return _contentTextView.text;
}

- (void)setTextFont:(UIFont *)textFont {
    _contentTextView.font = textFont;
    _placeHolderLabel.font = textFont;
}

- (UIFont *)textFont {
    return _contentTextView.font;
}

- (void)setTextColor:(UIColor *)textColor {
    _contentTextView.textColor = textColor;
}

- (UIColor *)textColor {
    return _contentTextView.textColor;
}

- (void)setBgColor:(UIColor *)bgColor {
    _contentTextView.backgroundColor = bgColor;
}

- (UIColor *)backgroundColor {
    return _contentTextView.backgroundColor;
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeHolderLabel;
}

- (UILabel *)characterLabel {
    if (!_characterLabel) {
        _characterLabel = [[UILabel alloc] init];
        _characterLabel.font = [UIFont systemFontOfSize:14.0];
        _characterLabel.text = [NSString stringWithFormat:@"0/%li",(long)_limitCharacter];
        _characterLabel.textColor = kColorByRGB(153, 153, 153, 1);
        _characterLabel.textAlignment = NSTextAlignmentRight;
    }
    return _characterLabel;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.contentTextView];
    [self addSubview:self.characterLabel];
    [_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-kScreenHeightRatio(20));
    }];
    [_characterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kScreenWidthRatio(5));
        make.top.mas_equalTo(_contentTextView.mas_bottom);
        make.height.mas_equalTo(kScreenHeightRatio(20));
    }];
    
    
}


@end
