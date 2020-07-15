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

@end
