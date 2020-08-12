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

- (RACSignal *)pageGoodsByCategoryggcsCode:(NSString *)ggcsCode PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self fg_getRequest:kpageGoodsByCategory paramters:@{@"ggcsCode":ggcsCode,@"pageNum":pageNum,@"pageSize":pageSize}];
}

- (RACSignal *)pageShopNewGoodssssNo:(NSString *)sssNo PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self fg_getRequest:kpageShopNewGoods paramters:@{@"sssNo":sssNo,@"pageNum":pageNum,@"pageSize":pageSize}];
}
@end
