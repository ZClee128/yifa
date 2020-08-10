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
@end
