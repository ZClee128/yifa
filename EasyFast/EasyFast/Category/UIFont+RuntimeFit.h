//
//  UIFont+RuntimeFit.h
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (RuntimeFit)

+ (UIFont *)runtimeFitFont:(CGFloat)fontSize;

+ (UIFont *)runtimeFitFont:(CGFloat)fontSize weight:(UIFontWeight)fontWeight;
@end

NS_ASSUME_NONNULL_END
