//
//  EFFollowVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowVM.h"

@implementation EFFollowVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findFollowShopList:self.firstPage];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFollowModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findFollowShopList:@([self.paging intValue]+1)];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFollowModel class] json:result.reqResult];
        return list;
    }];
}


- (RACSignal *)TransactionRefreshForeDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findTransactionShopList:self.firstPage];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFollowModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)TransactionRefreshForeUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findTransactionShopList:@([self.paging intValue]+1)];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFollowModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)TeamRefreshForeDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findTheTeamShopList:self.firstPage];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFollowModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)TeamRefreshForeUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findTheTeamShopList:@([self.paging intValue]+1)];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFollowModel class] json:result.reqResult];
        return list;
    }];
}


+ (RACSignal *)setFollowShopCategory:(NSString *)category shopNo:(NSString *)shopNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] setFollowShopCategory:category shopNo:shopNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)cancelFollowShop:(NSString *)shopNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] cancelFollowShop:shopNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}


@end