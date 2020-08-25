//
//  EFOrderVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderVM.h"
#import "PayManager.h"

@implementation EFOrderVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myOrderListpPageNum:self.firstPage type:self.type];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFOrderModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myOrderListpPageNum:@([self.paging intValue]+1) type:self.type];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFOrderModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)searchRefreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myOrderSearchListPageNum:self.firstPage type:self.type searchText:self.searchText];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFOrderModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)searchRefreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myOrderSearchListPageNum:@([self.paging intValue] + 1) type:self.type searchText:self.searchText];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFOrderModel class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)myOrderDetailExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] myOrderDetailExpressNum:expressNum orderNum:orderNum];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFOrderModel *model = [EFOrderModel modelWithJSON:result.reqResult];
        return model;
    }];
}

+ (RACSignal *)confirmReceiptExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] confirmReceiptExpressNum:expressNum orderNum:orderNum];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)urgedDeliveryOrderNum:(NSString *)orderNum {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] urgedDeliveryOrderNum:orderNum];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)orderExpressExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] orderExpressExpressNum:expressNum orderNum:orderNum];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFLogisticsModel *model = [EFLogisticsModel modelWithJSON:result.reqResult];
        return model;
    }];
}

- (RACSignal *)newGoodsRefreshForDown:(NSString *)sssNO {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageShopNewGoodssssNo:sssNO PageNum:self.firstPage pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)newGoodsRefreshForUp:(NSString *)sssNO {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageShopNewGoodssssNo:sssNO PageNum:@([self.paging intValue] + 1) pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)refreshOrder:(NSString *)orderNum payMethod:(NSInteger)payMethod {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] refreshOrder:orderNum payMethod:payMethod];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFPayStatusModel *model = [EFPayStatusModel modelWithJSON:result.reqResult];
        return model;
    }];
}

+ (RACSignal *)payForOrder:(NSString *)orderNum payMethod:(NSInteger)payMethod {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] payForOrder:orderNum payMethod:payMethod];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            NSDictionary *dict = result.reqResult;
            if ([dict[@"success"] boolValue]) {
                [[PayManager defaultManager] showPay:payMethod == 1 ? wxPay : aliPay resp:dict];
            }
        }
        return @(result.isSuccess);
    }];
}
@end
