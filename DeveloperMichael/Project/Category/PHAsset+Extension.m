//
//  PHAsset+Extension.m
//  DeveloperMichael
//
//  Created by 张炯 on 17/3/23.
//  Copyright © 2017年 张炯. All rights reserved.
//

#import "PHAsset+Extension.h"
#import <objc/runtime.h>

static char const *isSelectedKey = "isSelected";

@implementation PHAsset (Extension)


- (void)setIsSelected:(BOOL)isSelected{
    objc_setAssociatedObject(self, isSelectedKey, @(isSelected), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isSelected {
    return [objc_getAssociatedObject(self, isSelectedKey) boolValue];
}

@end
