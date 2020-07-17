//
//  NSString+NSMutableAttributedString.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "NSString+NSMutableAttributedString.h"

@implementation NSString (NSMutableAttributedString)


- (NSMutableAttributedString *)getAttributeWithChangeString:(NSString *)string ChangeFont:(UIFont *)changeFont textColor:(UIColor *)color{
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange range = [string rangeOfString:string];
    NSRange pointRange = NSMakeRange(range.location, range.length);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = changeFont;
    dic[NSForegroundColorAttributeName] = color;
    //赋值
    [attribut addAttributes:dic range:pointRange];
    return attribut;
}

@end
