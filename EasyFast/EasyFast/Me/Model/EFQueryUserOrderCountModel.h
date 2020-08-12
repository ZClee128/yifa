//
//  EFQueryUserOrderCountModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFQueryUserOrderCountModel : EFBaseModel

/// 我的订单-待发货数量
@property (nonatomic,strong)NSString *pendingDeliverCount;
/// 我的订单-待评价数量
@property (nonatomic,strong)NSString *pendingEvalCount;
/// 我的订单-待付款数量
@property (nonatomic,strong)NSString *pendingPayCount;
/// 我的订单-待收货数量
@property (nonatomic,strong)NSString *pendingReceiveCount;
/// 我的订单-退款/售后数量
@property (nonatomic,strong)NSString *pendingSaleCount;

@end

NS_ASSUME_NONNULL_END
