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
    return [self fg_postRequest:kmyOrderList paramters:@{@"pageNum":pageNum,@"type":@(type)}];
}

- (RACSignal *)myOrderSearchListPageNum:(NSNumber *)pageNum type:(NSInteger)type searchText:(NSString *)searchText {
    return [self fg_postRequest:kmyOrderSearchList paramters:@{@"pageNum":pageNum,@"type":@(type),@"searchText":searchText}];
}

- (RACSignal *)myOrderDetailExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self fg_postRequest:kmyOrderDetail paramters:@{@"expressNum":expressNum,@"orderNum":orderNum}];
}

- (RACSignal *)confirmReceiptExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self fg_postRequest:kconfirmReceipt paramters:@{@"expressNum":expressNum,@"orderNum":orderNum}];
}

- (RACSignal *)urgedDeliveryOrderNum:(NSString *)orderNum {
    return [self fg_postRequest:kurgedDelivery paramters:@{@"orderNum":orderNum}];
}

- (RACSignal *)orderExpressExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum {
    return [self fg_postRequest:korderExpress paramters:@{@"expressNum":expressNum,@"orderNum":orderNum}];
}
@end
