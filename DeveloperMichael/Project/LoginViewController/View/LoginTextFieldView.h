//
//  LoginTextFieldView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextFieldView : UIView

/** TextField */
@property (nonatomic, strong) UITextField *textField;


- (instancetype)initWithTextFieldLeftIcon:(NSString *)iconName placeholder:(NSString *)placeholder;



@end
