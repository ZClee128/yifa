//
//  EFEmptyView.m
//  EasyFast
//
//  Created by easyfast on 2020/8/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFEmptyView.h"

@implementation EFEmptyView

- (void)prepare{
    [super prepare];
    
    self.titleLabFont = RegularFont15;
    self.titleLabTextColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    
//    self.detailLabFont = [UIFont systemFontOfSize:17];
//    self.detailLabTextColor = tabbarBlackColor;
//    self.detailLabMaxLines = 5;
    
    self.actionBtnTitleColor = [tabbarBlackColor colorWithAlphaComponent:0.7];
    self.actionBtnHeight = WidthOfScale(25);
    self.actionBtnWidth = WidthOfScale(80);
    self.actionBtnCornerRadius = WidthOfScale(25)/2;
    self.actionBtnBorderWidth = 1;
    self.actionBtnBorderColor = RGB16(0xC3C3C3);
    self.actionBtnMargin = WidthOfScale(14.5);
    
    
}

+ (EFEmptyView *)NoNetEmptybtnClickBlock:(LYActionTapBlock )btnClickBlock{
    EFEmptyView *empty = [self emptyActionViewWithImage:UIImageMake(@"nonet") titleStr:@"网络竟然崩溃了" detailStr:@"" btnTitleStr:@"刷新" btnClickBlock:btnClickBlock];
    empty.emptyViewIsCompleteCoverSuperView = YES;
    return empty;
}

+ (EFEmptyView *)NoDataEmptybtnClickBlock:(LYActionTapBlock )btnClickBlock{
    EFEmptyView *empty = [self emptyActionViewWithImage:UIImageMake(@"nodata") titleStr:@"暂无数据" detailStr:@"" btnTitleStr:@"" btnClickBlock:btnClickBlock];
    empty.emptyViewIsCompleteCoverSuperView = YES;
    return empty;
}

@end
