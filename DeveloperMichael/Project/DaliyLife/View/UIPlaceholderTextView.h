//
//  PlaceholderTextView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/8.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceholderTextView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, assign) NSInteger limitCharacter;

@end
