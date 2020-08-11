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

/// 根据商家分类编码查询商品列表
- (RACSignal *)pageGoodsByCategoryggcsCode:(NSString *)ggcsCode PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;
@end

NS_ASSUME_NONNULL_END
