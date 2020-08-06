//
//  FMARCNetwork+Follow.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Follow)

/// 收藏店铺列表
- (RACSignal *)findCollectGoodsList:(NSNumber *)pageNum type:(NSInteger)type sortType:(NSInteger )sortType;

/// 关注店铺列表
- (RACSignal *)findFollowShopList:(NSNumber *)pageNum;

/// 交易过的店铺列表
- (RACSignal *)findTransactionShopList:(NSNumber *)pageNum;

/// 即将成团列表
- (RACSignal *)findTheTeamShopList:(NSNumber *)pageNum;

/// 关注店铺
- (RACSignal *)setFollowShopCategory:(NSString *)category shopNo:(NSString *)shopNo;

/// 取消关注店铺
- (RACSignal *)cancelFollowShop:(NSString *)shopNo;

/// 收藏商品
- (RACSignal *)setCollectGoods:(NSString *)goodsNo;

/// 取消收藏商品
- (RACSignal *)cancelCollectGoods:(NSString *)goodsNo;
@end

NS_ASSUME_NONNULL_END
