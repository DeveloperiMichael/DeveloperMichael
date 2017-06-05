//
//  UIImage+SAUImageHandle.h
//
//  Created by 张炯 on 16/12/16.
//  Copyright © 2016年 DeveloperMichael. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 裁剪图片风格 */
typedef NS_ENUM(NSInteger,ImageClipStyle) {
    ImageClipRectStyle=0,
    ImageClipOvalStyle,
};

@interface UIImage (SAUImageHandle)


/**
 改变图片透明度

 @param alpha 透明度 0.0~1.0
 @return 已改变透明度的图片
 */
- (UIImage *)sa_imageWithAlpha:(CGFloat)alpha;

/**
 任意改变图片尺寸

 @param size 需要的图片尺寸
 @return 已改变尺寸的图片
 */
- (UIImage *)sa_imageWithSize:(CGSize)size;


/**
 等比例放缩图片

 @param scale 放缩图片比例
 @return 已放缩后的图片
 */
- (UIImage *)sa_imageStretchWithScale:(CGFloat)scale;


/**
 裁剪图片 用贝塞尔曲线画图根据实际操作 这里仅提供常用类型裁剪

 @param rect 在原图片的基础上裁剪图片的rect
 @param style 裁剪图片风格
 @return 裁剪出来的图片
 */
- (UIImage *)sa_imageClipWithRect:(CGRect)rect andStyle:(ImageClipStyle)style;



/**
 图片压缩（质量）

 @param ratio 压缩比例0.0~1.0
 @return 质量压缩后的：图片数据流
 */
- (NSData *)sa_imageCompressReturnDataWithRatio:(CGFloat)ratio;


/**
 图片压缩（质量）

 @param ratio ratio 压缩比例0.0~1.0
 @return 质量压缩后的：图片
 */
- (UIImage *)sa_imageCompressReturnImageWithRatio:(CGFloat)ratio;


/**
 图片模糊

 @param level 模糊级别0.0~1.0
 @return 模糊处理后的图片
 */
- (UIImage *)sa_imageBlurWithLevel:(CGFloat)level;


/**
 图片旋转

 @param orientation 在原图片基础上旋转方向：左、右、下
 @return 旋转后的图片
 */
- (UIImage *)sa_imageRotateWithOrientation:(UIImageOrientation)orientation;


/**
 将UIView转化成图片

 @param theView 需要转化的UIView
 @return UIView的图片
 */
- (UIImage *)sa_getImageFromView:(UIView *)theView;


/**
 两张图片叠加、合成

 @param rect 本身图片对于合成图片的rect
 @param anotherImage 图片2
 @param anotherRect 图片2对于合成图片的rect
 @param size 合成图片的size
 @return 合成的图片
 */
- (UIImage *)sa_integrateImageWithRect:(CGRect)rect
                                 andAnotherImage:(UIImage *)anotherImage
                                anotherImageRect:(CGRect)anotherRect
                             integratedImageSize:(CGSize)size;

/**
 图片添加水印

 @param markImage 水印图片
 @param imgRect 水印图片对于原图片的rect
 @param alpha 水印图片透明度
 @param markStr 水印文字
 @param strRect 水印文字对于原图片的rect
 @param attribute 水印文字的设置颜色、字体大小
 @return 添加水印后的图片
 */
- (UIImage *)sa_imageWaterMark:(UIImage *)markImage
                     imageRect:(CGRect)imgRect
                markImageAlpha:(CGFloat)alpha
                    markString:(NSString *)markStr
                    stringRect:(CGRect)strRect
               stringAttribute:(NSDictionary *)attribute;



/**
 将颜色装换为该颜色图片

 @param color 颜色
 @return 对应颜色图片
 */
- (UIImage *)imageWithColor:(UIColor *)color;




@end
