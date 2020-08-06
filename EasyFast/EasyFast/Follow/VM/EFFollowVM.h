//
//  EFFollowVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFFollowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFFollowVM : EFBaseRefreshVM

+ (RACSignal *)setFollowShopCategory:(NSString *)category shopNo:(NSString *)shopNo;

+ (RACSignal *)cancelFollowShop:(NSString *)shopNo;

/// 交易过店铺的下拉
- (RACSignal *)TransactionRefreshForeDown;

/// 交易过店铺的上拉
- (RACSignal *)TransactionRefreshForeUp;

/// 成团下拉
- (RACSignal *)TeamRefreshForeDown;

/// 成团上拉
- (RACSignal *)TeamRefreshForeUp;
@end

NS_ASSUME_NONNULL_END
