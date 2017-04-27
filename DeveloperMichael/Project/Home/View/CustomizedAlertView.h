//
//  CustomizedAlertView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/4/26.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomizedAlertBlock)();

@interface CustomizedAlertView : UIView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)content
              leftButtonTitle:(NSString *)leftTitle
              leftButtonBlock:(CustomizedAlertBlock)leftBlock
             rightButtonTitle:(NSString *)rightTitle
             rightButtonBlock:(CustomizedAlertBlock)rightBlock;

- (void)presentAlertViewAnimated:(BOOL)animated completion:(CustomizedAlertBlock)completion;
- (void)dismissAlertViewAnimated:(BOOL)animated completion:(CustomizedAlertBlock)completion;

@end
