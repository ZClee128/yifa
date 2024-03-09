//
//  EFIMVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFIMVM.h"

@implementation EFIMVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myMessageListshopName:self.shopName];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFIMModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myMessageListshopName:self.shopName];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFIMModel class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)genUserSig {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] genUserSig];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

+ (RACSignal *)msgReaduserId:(NSString *)userId {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] msgReaduserId:userId];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)createSessiontoAccount:(NSString *)toAccount {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] createSessiontoAccount:toAccount];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

+ (RACSignal *)pageMsgHistoryDateTimeMills:(NSString *)dateTimeMills userId:(NSString *)userId pageSize:(NSNumber *)pageSize {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageMsgHistoryDateTimeMills:dateTimeMills userId:userId pageSize:pageSize];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFMessageModel class] json:result.reqResult];
        return list;
    }];
}
@end
