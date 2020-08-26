//
//  EFEmptyView.h
//  EasyFast
//
//  Created by easyfast on 2020/8/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "LYEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFEmptyView : LYEmptyView

+ (EFEmptyView *)NoNetEmptybtnClickBlock:(LYActionTapBlock )btnClickBlock;
+ (EFEmptyView *)NoDataEmptybtnClickBlock:(LYActionTapBlock )btnClickBlock;
@end

NS_ASSUME_NONNULL_END
