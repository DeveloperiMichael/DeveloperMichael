//
//  UIView+ViewFrameGeometry.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "UIView+ViewFrameGeometry.h"

@implementation UIView (ViewFrameGeometry)

- (void)setView_left:(CGFloat)view_left {
    CGRect newframe = self.frame;
    newframe.origin.x = view_left;
    self.frame = newframe;
}

- (CGFloat)view_left {
    return self.frame.origin.x;
}

- (void)setView_right:(CGFloat)view_right {
    CGFloat del = view_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += del ;
    self.frame = newframe;
}

- (CGFloat)view_right {
    return self.frame.origin.x+self.frame.size.width;
}

- (CGFloat)view_centerX {
    return self.center.x;
}

- (void)setView_centerX:(CGFloat)view_centerX {
    self.center = CGPointMake(view_centerX, self.center.y);
}

- (CGFloat)view_centerY {
    return self.center.y;
}

- (void)setView_centerY:(CGFloat)view_centerY {
    self.center = CGPointMake(self.center.x, view_centerY);
}

- (CGFloat)view_width {
    return self.frame.size.width;
}

- (void)setView_width:(CGFloat)view_width {
    CGRect newframe = self.frame;
    newframe.size.width = view_width;
    self.frame = newframe;
}

- (CGFloat)view_height {
    return self.frame.size.height;
}

- (void)setView_height:(CGFloat)view_height {
    CGRect newframe = self.frame;
    newframe.size.height = view_height;
    self.frame = newframe;
}

- (void)setView_top:(CGFloat)view_top {
    CGRect newframe = self.frame;
    newframe.origin.y = view_top;
    self.frame = newframe;
}

- (CGFloat)view_top {
    return self.frame.origin.y;
}

- (void)setView_bottom:(CGFloat)view_bottom {
    CGRect newframe = self.frame;
    newframe.origin.y = view_bottom - self.frame.size.height;;
    self.frame = newframe;
}

- (CGFloat)view_bottom {
    return self.frame.size.height+self.frame.origin.y;
}








@end
