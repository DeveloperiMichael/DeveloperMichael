//
//  UIImage+SAUImageHandle.m
//
//  Created by 张炯 on 16/12/16.
//  Copyright © 2016年 浙江网仓科技有限公司. All rights reserved.
//

#import "UIImage+SAUImageHandle.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (SAUImageHandle)


- (UIImage *)sa_imageWithAlpha:(CGFloat)alpha {
    if (alpha>1.0) {
        alpha = 1.0;
    }
    if (alpha<=0.0) {
        alpha = 0.0;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)sa_imageWithSize:(CGSize)size {
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

- (UIImage *)sa_imageStretchWithScale:(CGFloat)scale {
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)sa_imageClipWithRect:(CGRect)rect andStyle:(ImageClipStyle)style {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    UIBezierPath *path;
    switch (style) {
            case ImageClipRectStyle:path = [UIBezierPath bezierPathWithRect:rect];
            break;
            case ImageClipOvalStyle:path = [UIBezierPath bezierPathWithOvalInRect:rect];
            break;
        default:
            break;
    }
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}


- (NSData *)sa_imageCompressReturnDataWithRatio:(CGFloat)ratio {
    //UIImageJPEGRepresentation和UIImagePNGRepresentation
    if (ratio>1.0) {
        ratio = 1.0;
    }
    if (ratio<=0) {
        ratio = 0.0;
    }
    NSData *compressedData =  UIImageJPEGRepresentation(self, ratio);
    return compressedData;
}

- (UIImage *)sa_imageCompressReturnImageWithRatio:(CGFloat)ratio {
    //UIImageJPEGRepresentation和UIImagePNGRepresentation
    if (ratio>1.0) {
        ratio = 1.0;
    }
    if (ratio<=0) {
        ratio = 0.0;
    }
    NSData *compressedData =  UIImageJPEGRepresentation(self, ratio);
    UIImage *compressedImage = [UIImage imageWithData:compressedData];
    return compressedImage;
}

- (UIImage *)sa_imageBlurWithLevel:(CGFloat)level {
    if (level>1.0) {
        level = 1.0;
    }
    if (level<=0) {
        level = 0.0;
    }
    int boxSize = (int)(level * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


- (UIImage *)sa_imageRotateWithOrientation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    UIImage *rotatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rotatedImage;
}

- (UIImage *)sa_getImageFromView:(UIView *)theView {
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)sa_integrateImageWithRect:(CGRect)rect
                                 andAnotherImage:(UIImage *)anotherImage
                                anotherImageRect:(CGRect)anotherRect
                             integratedImageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:rect];
    [anotherImage drawInRect:anotherRect];
    UIImage *integratedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return integratedImage;
}

- (UIImage *)sa_imageWaterMark:(UIImage *)markImage
                     imageRect:(CGRect)imgRect
                markImageAlpha:(CGFloat)alpha
                    markString:(NSString *)markStr
                    stringRect:(CGRect)strRect
               stringAttribute:(NSDictionary *)attribute{
    
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    if (markImage) {
        [markImage drawInRect:imgRect blendMode:kCGBlendModeNormal alpha:alpha];
    }
    
    if (markStr) {
        //UILabel convert  to UIImage
        UILabel *markStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, strRect.size.width, strRect.size.height)];
        markStrLabel.textAlignment = NSTextAlignmentCenter;
        markStrLabel.numberOfLines = 0;
        markStrLabel.attributedText = [[NSAttributedString alloc] initWithString:markStr attributes:attribute];
        UIImage *image = [self sa_getImageFromView:markStrLabel];
        [image drawInRect:strRect blendMode:kCGBlendModeNormal alpha:1.0];;
    }
    UIImage *waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return waterMarkedImage;
}

@end
