//
//  CircleProgressView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/7.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

///progressColor,default is red
@property (nonatomic, strong) UIColor *progressColor;

///progressBackgroundColor,default is gray
@property (nonatomic, strong) UIColor *progressBackgroundColor;

///ProgressWidth,default is 3
@property (nonatomic, assign) CGFloat progressWidth;

///progressPercent,beyond 0 - 1
@property (nonatomic, assign) CGFloat progressPercent;

///is clockwise or not,default is 1 clockwise
@property (nonatomic, assign) BOOL clockwise;

///property of centerLabel
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIColor *labelbackgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@end
