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

/// 急速拼团  orderby 类型-1:降序，2:升序  type类型-1:最快，2:时间最短
- (RACSignal *)fastOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;

/// 急速拼团 列表
- (RACSignal *)pageTeamOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;

/// 首页搜索-获取搜索历史
- (RACSignal *)getSearchHistoryList;


/// 首页搜索-搜索商品列表
/// @param pageNum 1
/// @param pageSize 1
/// @param sortType 排序0-销量降序 1-价格降序 2-价格升序
/// @param title 搜索关键字
- (RACSignal *)searchGoodsListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize sortType:(NSInteger)sortType title:(NSString *)title;

/// 分页查询商品的拼团列表
/// @param ggNo 商品编码-ggNo
/// @param orderBy 排序方式-1:降序，2:升序
/// @param pageNum 页码,默认1
/// @param pageSize 需要查询的拼团数量，默认2条
/// @param teamInfo 是否包含团员信息-团员三个
/// @param type 顺序-1:最快（剩余最少），2:时间最短
- (RACSignal *)pageTeamByGoodsNoGGNo:(NSString *)ggNo orderBy:(NSInteger )orderBy pageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize teamInfo:(BOOL )teamInfo type:(NSInteger)type;


/// 根据商品编码查询商品摘要-拼团列表用
/// @param ggNo 商品编码-ggNo
- (RACSignal *)goodsSummaryGGNo:(NSString *)ggNo;

/// 拼团团员详情
/// @param ootNo 拼团的team编码-ootNo
- (RACSignal *)teamInfo:(NSString *)ootNo;
@end

NS_ASSUME_NONNULL_END
