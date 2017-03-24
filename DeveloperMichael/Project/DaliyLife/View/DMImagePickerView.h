//
//  DMImagePickerView.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/20.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "BaseView.h"

@interface DMImagePickerView : BaseView

/* 预览 */
@property (nonatomic, strong) UIButton *previewButton;

/* 完成 */
@property (nonatomic, strong) UIButton *doneButton;


/* 选择照片数量 */
@property (nonatomic, strong) UILabel *numberLabel;

@end
