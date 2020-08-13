//
//  EFSearchVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSearchVM.h"

@implementation EFSearchVM

+ (RACSignal *)getSearchHistoryList {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] getSearchHistoryList];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] searchGoodsListPageNum:self.firstPage pageSize:self.branches sortType:self.sortType title:self.title];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] searchGoodsListPageNum:@([self.paging intValue] + 1) pageSize:self.branches sortType:self.sortType title:self.title];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}
@end
