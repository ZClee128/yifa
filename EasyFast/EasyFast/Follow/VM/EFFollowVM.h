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

+ (RACSignal *)setCollectGoods:(NSString *)goodsNo;

+ (RACSignal *)cancelCollectGoods:(NSString *)goodsNo;

/// 交易过店铺的下拉
- (RACSignal *)TransactionRefreshForeDown;

/// 交易过店铺的上拉
- (RACSignal *)TransactionRefreshForeUp;
@end

NS_ASSUME_NONNULL_END
