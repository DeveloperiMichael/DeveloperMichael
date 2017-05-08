//
//  CalendarView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/5/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CalendarView.h"


@interface CalendarView()



@end

@implementation CalendarView

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




#pragma mark-
#pragma mark- Private Methods




#pragma mark-
#pragma mark- Getters && Setters

- (CalendarContentView *)calendarContentView {
    if (!_calendarContentView) {
        _calendarContentView = [[CalendarContentView alloc] init];
        _calendarContentView.backgroundColor = [UIColor yellowColor];
    }
    return _calendarContentView;
}

#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.calendarContentView];
    [_calendarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBarView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
    }];
}


@end
