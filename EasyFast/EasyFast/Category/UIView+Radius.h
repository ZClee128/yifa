//
//  UIView+Radius.h
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Radius)

- (void)ViewRadius;

- (void)ViewRadius:(CGFloat)radius;

/**
画圆边框

@param color 边框颜色
@param lineWidth 边框大小
*/
- (void)AddImageRadiusBorderWithColor:(UIColor *)color lineWidth:(CGFloat )lineWidth;


/// 画边框圆角
/// @param color 颜色
/// @param lineWidth 大小
/// @param radius 角度
- (void)AddImageRadiusBorderWithColor:(UIColor *)color lineWidth:(CGFloat )lineWidth radius:(CGFloat )radius;


- (void)AddImageRadius:(CGFloat )radius withUIRectCorner:(UIRectCorner)corners;

-(void)setTabBarShadowWithCenter:(CGPoint)center radius:(CGFloat)radius;

- (void)AddImage2PiRadiusBorderWithColor:(UIColor *)color lineWidth:(CGFloat )lineWidth radius:(CGFloat )radius;
@end

NS_ASSUME_NONNULL_END
