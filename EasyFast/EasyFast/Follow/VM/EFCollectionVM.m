//
//  EFCollectionVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFCollectionVM.h"

@implementation EFCollectionVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findCollectGoodsList:self.firstPage type:self.type sortType:self.sortType];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findCollectGoodsList:@([self.paging intValue] + 1) type:self.type sortType:self.sortType];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)setCollectGoods:(NSString *)goodsNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] setCollectGoods:goodsNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)cancelCollectGoods:(NSString *)goodsNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] cancelCollectGoods:goodsNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}
@end
