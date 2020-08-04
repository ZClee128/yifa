//
//  UILabel+Extension.h
//  Xqc.local
//
//  Created by 刘军军 on 17/5/26.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)


+ (UILabel *)itemLabelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor;


+ (UILabel *)itemLabelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font titleColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment;


+ (UILabel *)itemLabelWithCenter:(CGPoint)point Frame:(CGRect)frame text:(NSString *)text font:(CGFloat)font titleColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

+ (UILabel *)labelAdaptive:(NSString *)string font:(UIFont *)font maxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth;

+ (UILabel *)labelAdaptive:(NSString *)string font:(UIFont *)font maxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth lineSpace:(NSInteger)lineSpace;
- (CGSize)xqc_adaptionText:(NSString *)text numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)lineBreakMode boundingCGSize:(CGSize)size;
/**
 自动计算文本，会自动换行成多行
 
 @param text 格式为:@{@"文本内容" : @(文本的最大显示宽度)}
 */
- (void)setAdaptionText:(NSDictionary *)text;

/**
 自动计算单行文本，显示不完以...表示
 
 @param text 格式为:@{@"文本内容" : @(文本的最大显示宽度)}
 */
- (void)alineAdaptionText:(NSDictionary *)text;

/**
 默认的titleView的标签
 
 @param title title
 @return UILabel
 */
+ (UILabel *)titleView:(NSString *)title;


/**
 文本居中换行
 
 @param text 要显示的文字内容
 @param lines 是示几行
 @param lineBreakMode 对齐方式
 @param size 显示大小
 */
- (void)setAdaptionTextAlimentText:(NSString *)text numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)lineBreakMode boundingCGSize:(CGSize)size;

/**
 利用单例UILabel计算单行文本size

 @return 单行文本size
 */
- (CGSize)alineAdaption;

@end
