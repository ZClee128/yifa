//
//  FMARCNetwork+Order.m
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Order.h"

@implementation FMARCNetwork (Order)

- (RACSignal *)myOrderListpPageNum:(NSNumber *)pageNum type:(NSInteger)type {
    return [self fg_getRequest:kmyOrderList paramters:@{@"pageNum":pageNum,@"type":@(type)}];
}

- (RACSignal *)myOrderSearchListPageNum:(NSNumber *)pageNum type:(NSInteger)type searchText:(NSString *)searchText {
    return [self fg_getRequest:kmyOrderSearchList paramters:@{@"pageNum":pageNum,@"type":@(type),@"searchText":searchText}];
}

- (RACSignal *)myOrderDetailExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self fg_getRequest:kmyOrderDetail paramters:@{@"expressNum":expressNum,@"orderNum":orderNum}];
}

- (RACSignal *)confirmReceiptExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self fg_postRequest:kconfirmReceipt paramters:@{@"expressNum":expressNum,@"orderNum":orderNum}];
}

- (RACSignal *)urgedDeliveryOrderNum:(NSString *)orderNum {
    return [self fg_postRequest:kurgedDelivery paramters:@{@"orderNum":orderNum}];
}

- (RACSignal *)orderExpressExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self fg_getRequest:korderExpress paramters:@{@"expressNum":expressNum,@"orderNum":orderNum}];
}

- (RACSignal *)refreshOrder:(NSString *)orderNum payMethod:(NSInteger)payMethod {
    return [self fg_getRequest:krefreshOrder paramters:@{@"orderNum":orderNum,@"payMethod":@(payMethod)}];
}

- (RACSignal *)payForOrder:(NSString *)orderNum payMethod:(NSInteger)payMethod {
    return [self fg_postRequest:kpay paramters:@{@"orderNum":orderNum ? orderNum : @"",@"payMethod":@(payMethod)}];
}
@end
