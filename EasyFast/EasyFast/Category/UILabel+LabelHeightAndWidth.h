//
//  UILabel+LabelHeightAndWidth.h
//  TNHLTDP
//
//  Created by joincare on 2018/5/29.
//  Copyright © 2018年 NANBEI. All rights reserved.
//

#import <Foundation/Foundation.h>

#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

@interface UILabel (LabelHeightAndWidth)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;

/*
 * 根据最大尺寸获得label的宽高
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontName:(NSString *)fontName FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
@end
