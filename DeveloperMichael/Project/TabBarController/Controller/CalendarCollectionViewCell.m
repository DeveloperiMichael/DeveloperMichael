//
//  CalendarCollectionViewCell.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/5/9.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import "Masonry.h"
@interface CalendarCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end




@implementation CalendarCollectionViewCell


#pragma mark-
#pragma mark- View Life Cycle


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
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




#pragma mark-
#pragma mark- Getters && Setters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    NSArray *titleArray = [title componentsSeparatedByString:@"///"];
    NSString *topSrting = titleArray[0];
    NSString *bottomString = titleArray[1];
    if (titleArray.count>1) {
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",topSrting,bottomString] attributes:nil];
        NSRange stringRange = NSMakeRange([[titleString string] rangeOfString:@"\n"].location, bottomString.length+1);
        [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:stringRange];
        [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:stringRange];
        [_titleLabel setAttributedText:titleString];
    }else{
        _titleLabel.text = title;
    }
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}



@end
