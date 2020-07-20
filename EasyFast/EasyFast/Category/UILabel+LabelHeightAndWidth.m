//
//  UILabel+LabelHeightAndWidth.m
//  TNHLTDP
//
//  Created by joincare on 2018/5/29.
//  Copyright © 2018年 NANBEI. All rights reserved.
//

#import "UILabel+LabelHeightAndWidth.h"

@implementation UILabel (LabelHeightAndWidth)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontName:(NSString *)fontName FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    // paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes;
    CGSize labelSize;;
    if (iOS9Later) {
        attributes =@{NSFontAttributeName:[UIFont fontWithName:fontName size:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    }else{
        attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    }
    
    
    //如果是IOS6.0
    if (![text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        labelSize = [text sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    }else{
        
        // iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
        labelSize = [text boundingRectWithSize: maxSize
                                       options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributes
                                       context:nil].size;
    }
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

@end
