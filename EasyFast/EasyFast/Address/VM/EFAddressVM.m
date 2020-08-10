//
//  EFAddressVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/10.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFAddressVM.h"

@implementation EFAddressVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findAddressListPageNum:self.firstPage pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFAdsModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] findAddressListPageNum:@([self.paging intValue] + 1) pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFAdsModel class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)addAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] addAddress:address city:city province:province recipientName:recipientName recipientPhone:recipientPhone area:area];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)delAddress:(NSString *)addressNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] delAddress:addressNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)setDefaultAddress:(NSString *)addressNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] setDefaultAddress:addressNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)updateAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area addressNo:(NSString *)addressNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] updateAddress:address city:city province:province recipientName:recipientName recipientPhone:recipientPhone area:area addressNo:addressNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}
@end
