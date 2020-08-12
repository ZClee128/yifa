//
//  FMARCNetwork+Home.m
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Home.h"

@implementation FMARCNetwork (Home)

- (RACSignal *)activity {
    return [self fg_getRequest:kactivity paramters:@{}];
}

- (RACSignal *)banner {
    return [self fg_getRequest:kbanner paramters:@{}];
}

- (RACSignal *)notice {
    return [self fg_getRequest:knotice paramters:@{}];
}

- (RACSignal *)HomePageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self fg_getRequest:khome paramters:@{@"pageNum":pageNum,@"pageSize":pageSize}];
}

- (RACSignal *)pageGoodsByCategoryggcsCode:(NSString *)ggcsCode orderBy:(nonnull NSNumber *)orderBy PageNum:(nonnull NSNumber *)pageNum pageSize:(nonnull NSNumber *)pageSize {
    return [self fg_getRequest:kpageGoodsByCategory paramters:@{@"ggcsCode":ggcsCode,@"pageNum":pageNum,@"pageSize":pageSize,@"orderBy":orderBy}];
}

- (RACSignal *)pageShopNewGoodssssNo:(NSString *)sssNo PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self fg_getRequest:kpageShopNewGoods paramters:@{@"sssNo":sssNo,@"pageNum":pageNum,@"pageSize":pageSize}];
}

/// 急速拼团  orderby 类型-1:降序，2:升序  type类型-1:最快，2:时间最短
- (RACSignal *)fastOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self fg_getRequest:kfast paramters:@{@"orderBy":orderBy,@"type":type,@"pageNum":pageNum,@"pageSize":pageSize}];
}

- (RACSignal *)pageTeamOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self fg_getRequest:kpageTeam paramters:@{@"orderBy":orderBy,@"type":type,@"pageNum":pageNum,@"pageSize":pageSize}];
}
@end
