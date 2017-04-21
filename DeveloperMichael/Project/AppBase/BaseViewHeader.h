//
//  BaseViewHeader.h
//  DeveloperMichael
//
//  Created by 张炯 on 17/2/28.
//  Copyright © 2017年 张炯. All rights reserved.
//

#ifndef BaseViewHeader_h
#define BaseViewHeader_h

#import "Masonry.h"


static inline CGFloat kScreenWidthRatio(CGFloat width) {
    return CGRectGetWidth([UIScreen mainScreen].bounds) / 320.0f*width;
}

static inline CGFloat kScreenHeightRatio(CGFloat height) {
    return CGRectGetHeight([UIScreen mainScreen].bounds) / 568.0f*height;
}

static inline UIColor *kColorByRGB(CGFloat r,CGFloat g,CGFloat b,CGFloat alaph) {
    return [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:alaph];
}

static inline CGFloat kScreenHeight() {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

static inline CGFloat kScreenWidth() {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

static inline CGFloat StatusBarHeight() {
    return 20.0;
}

static inline CGFloat NavigationBarHeight() {
    return 44.0;
}

static inline CGFloat TabBarHeight() {
    return 49.0;
}

#define kColorByHex(hexValue,p)  [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:(p)]

///随机颜色
#define kRandomColor kColorByRGB(arc4random()%255,arc4random()%255,arc4random() %255,1)

#endif /* BaseViewHeader_h */
