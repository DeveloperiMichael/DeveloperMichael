//
//  SAButton.m
//  ZJKeepDevelop
//
//  Created by 张炯 on 16/11/17.
//  Copyright © 2016年 zhangjiong. All rights reserved.
//

#import "SAButton.h"

@interface SAButton(){
    float imageWidth;
    float imageHeight;
    float titleWidth;
    float titleheight;
}

@end

@implementation SAButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _interval = 0.0;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.imageView.backgroundColor = [UIColor clearColor];
    titleWidth = self.titleLabel.bounds.size.width;
    titleheight = self.titleLabel.bounds.size.height;
    [self setLocationType:self.locationType];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.imageView.backgroundColor = [UIColor clearColor];
    imageWidth = image.size.width;
    imageHeight = image.size.height;
    [self setLocationType:self.locationType];
}

- (void)setInterval:(float)interval{
    _interval = interval;
    [self setLocationType:self.locationType];
}

- (void)setLocationType:(ImageTitleLocationType)locationType{
    _locationType = locationType;
    switch (locationType) {
        case ImageLocateLeftAndTotalCenter:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -_interval*0.5, 0, _interval*0.5);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, _interval*0.5, 0,-_interval*0.5);
        }
            break;
        case ImageLocateRightAndTotalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0,titleWidth+_interval*0.5, 0, -(titleWidth+_interval*0.5));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth+_interval*0.5), 0, imageWidth+_interval*0.5);
        }
            break;
        case ImageLocateLeftAndTotalLeft:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, _interval, 0,-_interval);

        }
            break;
        case ImageLocateRightAndTotalLeft:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0,titleWidth+_interval, 0, -(titleWidth+_interval));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case ImageLocateLeftAndTotalRight:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -_interval, 0, _interval);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,0);
        }
            break;
        case ImageLocateRightAndTotalRight:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0,titleWidth, 0, -(titleWidth));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth+_interval), 0, imageWidth+_interval);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case ImageLocateTopAndTotalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0,0, titleheight + _interval, -(titleWidth));
            self.titleEdgeInsets = UIEdgeInsetsMake(imageHeight + _interval, -(imageWidth), 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ImageLocateBottomAndTotalCenter:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0,0, -(titleheight + _interval), -titleWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageHeight + _interval),-imageWidth, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        default:
            break;
    }
}

@end
