//
//  UIFont+RuntimeFit.m
//  flag
//
//  Created by zclee on 2020/5/16.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "UIFont+RuntimeFit.h"
#import <objc/runtime.h>


@implementation UIFont (RuntimeFit)

+ (void)load {
    Method selfMethod = class_getClassMethod([self class], @selector(runtimeFitFont:));
    Method systenMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
    method_exchangeImplementations(selfMethod, systenMethod);
    
    Method selfMethod2 = class_getClassMethod([self class], @selector(runtimeFitFont:weight:));
    Method systenMethod2 = class_getClassMethod([self class], @selector(systemFontOfSize:weight:));
    method_exchangeImplementations(selfMethod2, systenMethod2);
}

+ (UIFont *)runtimeFitFont:(CGFloat)fontSize {
    UIFont *fitFont = nil;
    //这里并不会造成递归调用,方法已经被交换
    fitFont = [UIFont runtimeFitFont: fontSize *(kPHONE_WIDTH / 375 )];
    return fitFont;
}

+ (UIFont *)runtimeFitFont:(CGFloat)fontSize weight:(UIFontWeight)fontWeight {
    UIFont *fitFont = nil;
    fitFont = [UIFont runtimeFitFont: fontSize *(kPHONE_WIDTH / 375 ) weight:fontWeight];
    return fitFont;
}

@end
