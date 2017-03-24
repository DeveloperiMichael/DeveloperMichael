//
//  BaseView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/2.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewHeader.h"
#import "SAButton.h"

@class BaseView;

//代理
@protocol BaseViewDelegate<NSObject>

@optional

-(void)leftButtonClicked:(BaseView *)view;
-(void)rightButtonClicked:(BaseView *)view;

@end

//本类
@interface BaseView : UIView{
    
}

@property(nonatomic, assign) id<BaseViewDelegate> delegate;

@property(strong,nonatomic) UIView *navBarView;
@property(strong,nonatomic) UILabel *titleLabel;
@property(strong,nonatomic) SAButton *rightButton;
@property(strong,nonatomic) SAButton *leftButton;
@property(strong,nonatomic) UIImageView *bgImageView;
@property(strong,nonatomic) UIImageView *navBarImageView;

@end
