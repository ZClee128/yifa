//
//  UIImage+Darw.h
//  EasyFast
//
//  Created by zclee on 2020/7/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Darw)

//通过颜色生成一张图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//给图片切割圆角
+ (UIImage *)setCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;
//根据颜色生成一张带圆角的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)imageWithMixColors:(NSArray *)colors size:(CGSize)size;
+ (UIImage *)combineImageUpImage:(UIImage *)upImage  DownImage:(UIImage *)downImage;
+ (UIImage *)imageWithVerticalMixColors:(NSArray *)colors size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
