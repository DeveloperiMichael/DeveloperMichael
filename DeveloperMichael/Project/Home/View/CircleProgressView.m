//
//  CircleProgressView.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/7.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "CircleProgressView.h"
#import "BaseViewHeader.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation CircleProgressView

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)layoutSubviews {
     [super addSubview:self.centerLabel];
    self.centerLabel.backgroundColor = self.labelbackgroundColor;
    self.centerLabel.textColor = self.textColor;
    self.centerLabel.font = self.textFont;
    [self addSubview:self.centerLabel];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, YES); // 平滑
    CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, 0, M_PI*2, 0);
    [self.progressBackgroundColor setStroke];
    CGContextSetLineWidth(context, self.progressWidth);
    CGContextStrokePath(context);
    
    if(self.progressPercent)
    {
        CGFloat angle = 2 * self.progressPercent * M_PI - M_PI_2;
        if(!self.clockwise) {// 反方向
            CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, ((int)self.progressPercent == 1 ? -M_PI_2 : angle), -M_PI_2, 0);
        }
        else {// 正方向
            CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, -M_PI_2, angle, 0);
        }
        [self.progressColor setStroke];
        CGContextSetLineWidth(context, self.progressWidth);
        CGContextStrokePath(context);
    }
}


#pragma mark-
#pragma mark- delegate





#pragma mark-
#pragma mark- Event response




#pragma mark-
#pragma mark- Private Methods

/* init default data */
- (void)initData {
    self.progressColor = kColorByRGB(226, 30, 3, 1);
    self.progressWidth = 3.0;
    self.progressPercent = 0.0;
    self.clockwise = 1;
    self.progressBackgroundColor = [UIColor grayColor];
    
    self.labelbackgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:15];
}


#pragma mark-
#pragma mark- Getters && Setters

- (void)setProgressPercent:(CGFloat)progressPercent
{
    if(self.progressPercent < 0) return;
    _progressPercent = progressPercent;
    [self setNeedsDisplay];
}

- (UILabel *)centerLabel
{
    if(!_centerLabel)
    {
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.progressWidth + 5, 0, WIDTH - (self.progressWidth +5) * 2, HEIGHT/2)];
        _centerLabel.center = CGPointMake(WIDTH/2, HEIGHT/2);
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.userInteractionEnabled = YES;
        _centerLabel.layer.cornerRadius = 5.0;
        _centerLabel.clipsToBounds = YES;
        [_centerLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCenterLabel:)]];
    }
    return _centerLabel;
}



@end
