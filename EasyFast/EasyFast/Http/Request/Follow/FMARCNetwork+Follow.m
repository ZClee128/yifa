//
//  FMARCNetwork+Follow.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Follow.h"

@implementation FMARCNetwork (Follow)

- (RACSignal *)findCollectGoodsList:(NSNumber *)pageNum type:(NSInteger)type sortType:(NSInteger)sortType{
    return [self fg_getRequest:kfindCollectGoodsList paramters:@{@"pageNum":pageNum,@"type":@(type),@"sortType":@(sortType)}];
}

- (RACSignal *)findFollowShopList:(NSNumber *)pageNum {
    return [self fg_getRequest:kfindFollowShopList paramters:@{@"pageNum":pageNum}];
}

- (RACSignal *)findTransactionShopList:(NSNumber *)pageNum {
    return [self fg_getRequest:kfindTransactionShopList paramters:@{@"pageNum":pageNum}];
}

- (RACSignal *)findTheTeamShopList:(NSNumber *)pageNum  {
    return [self fg_getRequest:kfindTheTeamShopList paramters:@{@"pageNum":pageNum}];
}

- (RACSignal *)setFollowShopCategory:(NSString *)category shopNo:(NSString *)shopNo {
    return [self fg_postRequest:ksetFollowShop paramters:@{@"category":category,@"shopNo":shopNo}];
}

- (RACSignal *)cancelFollowShop:(NSString *)shopNo {
    return [self fg_postRequest:kcancelFollowShop paramters:@{@"shopNo":shopNo}];
}

- (RACSignal *)setCollectGoods:(NSString *)goodsNo {
    return [self fg_postRequest:ksetCollectGoods paramters:@{@"goodsNo":goodsNo}];
}

- (RACSignal *)cancelCollectGoods:(NSString *)goodsNo {
    return [self fg_postRequest:kcancelCollectGoods paramters:@{@"goodsNo":goodsNo}];
}
@end
