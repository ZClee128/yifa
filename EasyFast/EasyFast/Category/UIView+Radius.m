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

- (void)AddImageRadius:(CGFloat )radius withUIRectCorner:(UIRectCorner)corners{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = self.bounds;

    maskLayer.path = maskPath.CGPath;

    self.layer.mask = maskLayer;

}


/**
 给tabbar添加阴影，中间有一个圆形的凸起
 @param center 圆弧中心
 @param radius 圆弧半径
 */
-(void)setTabBarShadowWithCenter:(CGPoint)center radius:(CGFloat)radius {
    CAShapeLayer *layer = [CAShapeLayer new];
    //背景填充色
    layer.fillColor = [UIColor redColor].CGColor;
    layer.shadowColor = RGB16(0xf5f5f5).CGColor;
    layer.shadowOffset = CGSizeMake(7, 3);
    layer.shadowOpacity = 1;
    
    CGFloat a = center.y;
    CGFloat angle = asin(a/radius);
    //初始化一个路径
    UIBezierPath* path = [UIBezierPath bezierPath];
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    //起点
    [path moveToPoint:CGPointMake(0, 0)];
    //绘制一条圆弧
    [path addArcWithCenter:center radius:radius startAngle:angle + M_PI endAngle:2*M_PI - angle clockwise:YES];
    [path addLineToPoint:CGPointMake(kScreenWidth, 0)];
    [path addLineToPoint:CGPointMake(kScreenWidth, TAB_SAFE_HEIGHT)];
    [path addLineToPoint:CGPointMake(0, TAB_SAFE_HEIGHT)];
    // 根据坐标点连线
    //    [path stroke];
    layer.path = [path CGPath];
    [path closePath];
    layer.shadowPath = [path CGPath];
    
    [self.layer insertSublayer:layer atIndex:0];
}
@end
