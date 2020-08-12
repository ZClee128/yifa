//
//  FMARCNetwork+Home.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Home)

/// 查询活动信息
- (RACSignal *)activity;

/// banner
- (RACSignal *)banner;

/// 查询公告信息
- (RACSignal *)notice;

/// 首页批发
- (RACSignal *)HomePageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;

/// 根据商家分类编码查询商品列表  orderBy排序方式，0：全部,1:销量，2：价格升序，3：价格降序，4：新品
- (RACSignal *)pageGoodsByCategoryggcsCode:(NSString *)ggcsCode orderBy:(NSNumber *)orderBy PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;

/// 店铺新品
- (RACSignal *)pageShopNewGoodssssNo:(NSString *)sssNo PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;
@end

NS_ASSUME_NONNULL_END