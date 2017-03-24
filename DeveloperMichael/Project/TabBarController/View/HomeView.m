//
//  HomeView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/16.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

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

- (UITableView *)homeTableView {
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.backgroundColor = kColorByRGB(0, 0, 0, 0.4);
    }
    return _homeTableView;
}


#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    [self addSubview:self.homeTableView];
    [_homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.navBarView.mas_bottom);
    }];
}


@end
