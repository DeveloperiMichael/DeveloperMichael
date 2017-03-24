//
//  DaliyLifeView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "DaliyLifeView.h"

@interface DaliyLifeView ()



@end

@implementation DaliyLifeView

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



#pragma mark-
#pragma mark- SetupConstraints

- (void)setupSubviewsContraints{
    self.titleLabel.text = @"Daliy Life";
    self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 13);
    [self.rightButton setTitle:@"" forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"icon_publish"] forState:UIControlStateNormal];
    
}

@end
