//
//  EFMessageCellData.m
//  EasyFast
//
//  Created by easyfast on 2020/9/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMessageCellData.h"

@implementation EFMessageCellData

- (CGSize)contentSize
{
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15] } context:nil];
    CGSize size = CGSizeMake(ceilf(rect.size.width)+1, ceilf(rect.size.height));

    // 加上气泡边距
    size.height += 60;
    size.width += 20;

    return size;
}

@end
