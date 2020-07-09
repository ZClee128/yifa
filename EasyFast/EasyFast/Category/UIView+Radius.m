//
//  UIView+Radius.m
//  flag
//
//  Created by zclee on 2020/5/18.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "UIView+Radius.h"


@implementation UIView (Radius)

- (void)ViewRadius {
    [self ViewRadius:self.size.width / 2];
}

- (void)ViewRadius:(CGFloat )radius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)AddImageRadiusBorderWithColor:(UIColor *)color lineWidth:(CGFloat )lineWidth {
    CGFloat point = self.frame.size.width / 2;
    CGFloat r = (self.frame.size.width - lineWidth) / 2;
    CGFloat startAngle = 0.0;
    CGFloat endAngle = M_PI * 2;
//
    UIBezierPath *pathDraw = [UIBezierPath bezierPathWithArcCenter:CGPointMake(point, point) radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init] ;
    layer.path = pathDraw.CGPath;

    layer.lineWidth = lineWidth;
//
    layer.fillColor  = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;

    [self.layer addSublayer:layer];
}

- (void)AddImageRadiusBorderWithColor:(UIColor *)color lineWidth:(CGFloat )lineWidth radius:(CGFloat )radius{
   
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init] ;
    layer.path = maskPath.CGPath;

    layer.lineWidth = lineWidth;
//
    layer.fillColor  = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;

    [self.layer addSublayer:layer];
}

@end
