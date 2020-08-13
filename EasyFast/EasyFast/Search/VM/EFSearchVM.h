//
//  EFSearchVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFGoodsList.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFSearchVM : EFBaseRefreshVM

@property (nonatomic,assign)NSInteger sortType;
@property (nonatomic,strong)NSString *title;
+ (RACSignal *)getSearchHistoryList;
@end

NS_ASSUME_NONNULL_END
