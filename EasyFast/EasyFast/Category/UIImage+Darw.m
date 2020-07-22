//
//  UIImage+Darw.m
//  EasyFast
//
//  Created by zclee on 2020/7/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "UIImage+Darw.h"

@implementation UIImage (Darw)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius{
    
    UIImage *image = [self imageWithColor:color size:size];
    
    UIImage *newImage = [self setCornerWithImage:image cornerRadius:cornerRadius];
    
    return newImage;
}

+ (UIImage *)setCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:cornerRadius];
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextAddPath(ctx, path.CGPath);
    
    CGContextClip(ctx);
    
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageWithMixColors:(NSArray *)colors size:(CGSize)size
{
    CAGradientLayer *layer = [UIView gradientLocationLayer:colors frame:CGRectMake(0.0f, 0.0f, size.width, size.height) direction:XQCGradientColorDirectionHorizontal];
    
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)imageWithVerticalMixColors:(NSArray *)colors size:(CGSize)size
{
    CAGradientLayer *layer = [UIView gradientLocationLayer:colors frame:CGRectMake(0.0f, 0.0f, size.width, size.height) direction:XQCGradientColorDirectionVertical];
    
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return outputImage;
}


+ (UIImage *)combineImageUpImage:(UIImage *)upImage  DownImage:(UIImage *)downImage{
    
    UIImage * image1 = upImage;
    UIImage * image2 = downImage;
    
    if (image1 == nil) {
        return image2;
    }
    CGFloat width = image1.size.width;
    CGFloat height = image1.size.height  + image2.size.height;
    CGSize offScreenSize = CGSizeMake(width, height);
    // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, [UIScreen mainScreen].scale);
    
    CGRect rectUp = CGRectMake(0, 0, image1.size.width, image1.size.height);
    [image1 drawInRect:rectUp];
    
    CGRect rectDown = CGRectMake((width - image2.size.width)/2, rectUp.origin.y + rectUp.size.height, image2.size.width, image2.size.height);
    [image2 drawInRect:rectDown];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imagez;
}

@end
