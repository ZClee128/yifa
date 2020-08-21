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
    
    self.titleLabFont = [UIFont systemFontOfSize:25];
    self.titleLabTextColor = tabbarBlackColor;
    
    self.detailLabFont = [UIFont systemFontOfSize:17];
    self.detailLabTextColor = tabbarBlackColor;
    self.detailLabMaxLines = 5;
    
    self.actionBtnBackGroundColor = colorF14745;
    self.actionBtnTitleColor = [UIColor whiteColor];
}

+ (EFEmptyView *)NoNetEmptybtnClickBlock:(LYActionTapBlock )btnClickBlock{
    EFEmptyView *empty = [self emptyActionViewWithImage:UIImageMake(@"") titleStr:@"网络错误" detailStr:@"请检查网络" btnTitleStr:@"重试" btnClickBlock:btnClickBlock];
    empty.emptyViewIsCompleteCoverSuperView = YES;
    return empty;
}

@end
