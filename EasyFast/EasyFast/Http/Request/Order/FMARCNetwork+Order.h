//
//  FMARCNetwork+Order.h
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Order)

/// 类型，1：全部；2：待付款，3：待发货，4：待收货，5：待评价
- (RACSignal *)myOrderListpPageNum:(NSNumber *)pageNum type:(NSInteger)type;

/// 搜索订单
- (RACSignal *)myOrderSearchListPageNum:(NSNumber *)pageNum type:(NSInteger)type searchText:(NSString *)searchText;

/// 订单详情
- (RACSignal *)myOrderDetailExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;

/// 确认收货
- (RACSignal *)confirmReceiptExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;

/// 催促发货
- (RACSignal *)urgedDeliveryOrderNum:(NSString *)orderNum;

/// 物流
- (RACSignal *)orderExpressExpressNum:(NSString *)expressNum orderNum:(NSString *)orderNum;

/// 查询支付结果
- (RACSignal *)refreshOrder:(NSString *)orderNum payMethod:(NSInteger)payMethod;

/// 第三方下单
- (RACSignal *)payForOrder:(NSString *)orderNum payMethod:(NSInteger)payMethod;
@end

NS_ASSUME_NONNULL_END
