//
//  EFPayStatusModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFPayStatusModel : EFBaseModel

/// 支付宝交易状态。WAIT_BUYER_PAY：待支付，TRADE_SUCCESS/TRADE_FINISHED：交易成功，TRADE_CLOSED：超时/已退款
@property (nonatomic,strong)NSString *aliTradeState;
/// 状态说明
@property (nonatomic,strong)NSString *msg;
/// 支付状态，1：待支付，2：已支付，3：交易失败
@property (nonatomic,assign)NSInteger payState;
/// 订单查询状态，只代表第三方接口响应正常
@property (nonatomic,assign)BOOL success;
/// 微信交易状态。USERPAYING：待支付，SUCCESS：交易成功，NOTPAY/CLOSED:未支付/交易关闭/已退款，REVOKED/PAYERROR:已撤销/支付失败
@property (nonatomic,strong)NSString *wxTradeState;
/// 订单类型，1：单独购买，2：拼团
@property (nonatomic,assign)NSInteger orderType;
@end

NS_ASSUME_NONNULL_END
