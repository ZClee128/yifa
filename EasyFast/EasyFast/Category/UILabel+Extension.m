//
//  UILabel+Extension.m
//  Xqc.local
//
//  Created by 刘军军 on 17/5/26.
//
//

#import "UILabel+Extension.h"
#import "UIView+Frame.h"

static UILabel *adaptionLabel = nil;

@implementation UILabel (Extension)

+ (UILabel *)itemLabelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font titleColor:(UIColor *)color backgroundColor:(UIColor *)bgColor{
    
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:font];
    lab.textColor = color;
    lab.backgroundColor = bgColor;
    
    return lab;
}


+ (UILabel *)itemLabelWithFrame:(CGRect)frame text:(NSString *)text font:(CGFloat)font titleColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment
{
    
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:font];
    lab.textColor = color;
    lab.textAlignment = alignment;
    
    return lab;
}

+ (UILabel *)itemLabelWithCenter:(CGPoint)point Frame:(CGRect)frame text:(NSString *)text font:(CGFloat)font titleColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment{
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = frame;
    lab.center = point;
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:font];
    lab.textColor = color;
    lab.textAlignment = alignment;
    
    return lab;
}

+ (UILabel *)labelAdaptive:(NSString *)string font:(UIFont *)font maxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth
{
    CGFloat w = (maxWidth == 0 ? kPHONE_WIDTH : maxWidth);
    CGFloat h = (maxHeight == 0 ? kPHONE_HEIGHT : maxHeight);
    NSDictionary *dictionary = @{NSFontAttributeName : font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(w, h)
                                       options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                    attributes:dictionary
                                       context:nil].size;
    if (size.width > w) {
        size = CGSizeMake(w, size.height);
    }
    if (size.height > h) {
        size = CGSizeMake(size.width, h);
    }
    UILabel *label = [[UILabel alloc] initWithSize:size];
    label.text = string;
    label.font = font;
    label.numberOfLines = (label.height > label.font.lineHeight ? 0 : 1);
    label.lineBreakMode = (label.numberOfLines == 0 ? NSLineBreakByCharWrapping : NSLineBreakByWordWrapping);
    return label;
}


+ (UILabel *)labelAdaptive:(NSString *)string font:(UIFont *)font maxHeight:(CGFloat)maxHeight maxWidth:(CGFloat)maxWidth lineSpace:(NSInteger)lineSpace
{
    CGFloat w = (maxWidth == 0 ? kPHONE_WIDTH : maxWidth);
    CGFloat h = (maxHeight == 0 ? kPHONE_HEIGHT : maxHeight);
    NSDictionary *dictionary = @{NSFontAttributeName : font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(w, h)
                                       options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                    attributes:dictionary
                                       context:nil].size;
    if (size.width > w) {
        size = CGSizeMake(w, size.height);
    }
    if (size.height > h) {
        size = CGSizeMake(size.width, h);
    }
    UILabel *label = [[UILabel alloc] initWithSize:size];
    CGFloat newH = [self calculateLabelHeightWithText:string lineSpace:lineSpace fontName:font size:CGSizeMake(w, h) label:label];
//    label.text = string;
    size.height = newH;
    label.size = size;
    label.font = font;
    label.numberOfLines = (label.height > label.font.lineHeight ? 0 : 1);
    label.lineBreakMode = (label.numberOfLines == 0 ? NSLineBreakByCharWrapping : NSLineBreakByWordWrapping);
    return label;
}


+ (CGFloat)calculateLabelHeightWithText:(NSString*)text lineSpace:(NSInteger)lineSpace fontName:(UIFont*)fontName size:(CGSize)size label:(UILabel*)label{
    CGFloat height =0;
    if(text.length>0) {
        // 计算内容高度,判断显示几行
        NSString*firstWord = [text substringToIndex:1];
        CGFloat oneRowHeight = [firstWord sizeWithAttributes:@{NSFontAttributeName:fontName}].height;
        NSDictionary *attributes =@{NSFontAttributeName:fontName};
        CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        CGFloat rows = textSize.height/ oneRowHeight; //此处为一行时候
        if(rows ==1) {
            lineSpace =0;
            height = oneRowHeight;
        }else if(rows >1){
            height = (oneRowHeight + lineSpace) * rows;
        }
        if(label) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:lineSpace];
            [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,text.length)];
            [label setAttributedText:string];
        }
    }
    return height;
}


#pragma mark - Adaption

- (void)setAdaptionText:(NSDictionary *)text
{
    [self setAdaptionText:text.allKeys.firstObject numberOfLines:0 lineBreakMode:NSLineBreakByCharWrapping boundingCGSize:CGSizeMake([text.allValues.firstObject doubleValue], MAXFLOAT)];
}

- (void)alineAdaptionText:(NSDictionary *)text
{
    [self setAdaptionText:text.allKeys.firstObject numberOfLines:1 lineBreakMode:NSLineBreakByTruncatingTail boundingCGSize:CGSizeMake([text.allValues.firstObject doubleValue], self.font.lineHeight)];
}

- (CGSize)alineAdaption
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        adaptionLabel = [[UILabel alloc] init];
    });
    adaptionLabel.font = self.font;
    CGSize size = [adaptionLabel xqc_adaptionText:self.text numberOfLines:1 lineBreakMode:NSLineBreakByTruncatingTail boundingCGSize:CGSizeMake(kPHONE_WIDTH, self.font.lineHeight)];
    return size;
}

- (void)setAdaptionText:(NSString *)text numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)lineBreakMode boundingCGSize:(CGSize)size
{
    self.size = [self xqc_adaptionText:text numberOfLines:lines lineBreakMode:lineBreakMode boundingCGSize:size];
}

- (CGSize)xqc_adaptionText:(NSString *)text numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)lineBreakMode boundingCGSize:(CGSize)size
{
    self.text = text;
    self.numberOfLines = lines;
    self.lineBreakMode = lineBreakMode;
    NSDictionary *dictionary = @{NSFontAttributeName : self.font};
    CGSize labelCGSize = [self.text boundingRectWithSize:size
                                                 options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                              attributes:dictionary
                                                 context:nil].size;
    return CGSizeMake(ceil(labelCGSize.width), ceil(labelCGSize.height));
}

- (void)setAdaptionTextAlimentText:(NSString *)text numberOfLines:(NSInteger)lines lineBreakMode:(NSLineBreakMode)lineBreakMode boundingCGSize:(CGSize)size
{
    self.text = text;
    self.numberOfLines = lines;
    self.lineBreakMode = lineBreakMode;
    self.textAlignment = NSTextAlignmentCenter;
    NSDictionary *dictionary = @{NSFontAttributeName : self.font};
    CGSize labelCGSize = [self.text boundingRectWithSize:size
                                                 options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                              attributes:dictionary
                                                 context:nil].size;
    self.size = CGSizeMake(ceil(labelCGSize.width), ceil(labelCGSize.height));
}

+ (UILabel *)titleView:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    [label alineAdaptionText:@{title : @(kPHONE_WIDTH/3*2)}];
    label.font = RegularFont17;
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
