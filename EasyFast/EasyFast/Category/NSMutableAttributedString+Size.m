//
//  NSMutableAttributedString+Size.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "NSMutableAttributedString+Size.h"

@implementation NSAttributedString (Size)


- (CGFloat)AttributedStringFont:(UIFont*)font maxHeight:(CGFloat)height{
    
    CGFloat width = 0;
    
    do{
        
        if(self.length<=0) {
            
            break;
            
        }
        
        NSDictionary *attribute = @{NSFontAttributeName:font};
        
        CGRect retSize = [self.string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine |
                          
                          NSStringDrawingUsesLineFragmentOrigin |
                          
                          NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        
        width = retSize.size.width;
        
    }while(0);
    
    return ceil(width);
    
}

@end
