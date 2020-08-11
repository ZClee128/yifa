//
//  EFOrderModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"
#import "EFAddressModel.h"
#import "EFExpressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFOrderGoodsModel : EFBaseModel

/// 商品主图
@property (nonatomic,strong)NSString *goodsImage;
/// 商品编号
@property (nonatomic,strong)NSString *goodsNo;
/// 商品单价
@property (nonatomic,assign)CGFloat goodsPrice;
/// 商品属性集合
@property (nonatomic,strong)NSString *goodsProperty;
/// 商品SKU编号
@property (nonatomic,strong)NSString *goodsSkuNo;
/// 商品名称
@property (nonatomic,strong)NSString *goodsTitle;
/// 商品件数
@property (nonatomic,assign)NSInteger quantity;
/// 是否售后，0：否；1：是；
@property (nonatomic,assign)NSInteger isAftersale;

@end


@interface EFOrderModel : EFBaseModel
/// 物流单号
@property (nonatomic,strong)NSString *expressNum;
/// 商品集合
@property (nonatomic,strong)NSArray<EFOrderGoodsModel *> *goodsList;
/// 主订单编码
@property (nonatomic,strong)NSString *orderNo;
/// 订单号
@property (nonatomic,strong)NSString *orderNum;
/// 订单支付状态, 1：未支付；2：已支付
@property (nonatomic,assign)NSInteger orderPayState;
/// 订单状态，100：未付款、200：待发货、300：待收货、400：待评价、500：退款/售后、600：已完成、800：已失效
@property (nonatomic,assign)NSInteger orderState;
/// 子订单编码
@property (nonatomic,strong)NSString *orderSubNo;
/// 购买数量
@property (nonatomic,assign)NSInteger quantity;
/// 店铺编码
@property (nonatomic,strong)NSString *shopNo;
/// 店铺名称
@property (nonatomic,strong)NSString *shopTitle;
/// 合计金额
@property (nonatomic,assign)CGFloat totalAmount;
/// 收货信息
@property (nonatomic,strong)EFAddressModel *address;
/// 物流信息
@property (nonatomic,strong)EFExpressModel *express;
/// 支付方式，1：微信、2：支付宝
@property (nonatomic,assign)NSInteger payMethod;
/// 支付状态, 0：待支付、1：已支付
@property (nonatomic,assign)NSInteger payState;
/// 创建时间
@property (nonatomic,strong)NSString *createTime;
/// 发货时间
@property (nonatomic,strong)NSString *deliverTime;
/// 付款时间
@property (nonatomic,strong)NSString *payTime;
/// 优惠金额
@property (nonatomic,assign)CGFloat discountAmount;
/// 邮费金额
@property (nonatomic,assign)CGFloat postageAmount;
/// 邮费优惠金额
@property (nonatomic,assign)CGFloat postageDiscountAmount;
/// 商品总价
@property (nonatomic,assign)CGFloat goodsTotalAmount;
/// 商品价格
@property (nonatomic,assign)CGFloat goodsAmount;
/// 结束时间
@property (nonatomic,strong)NSDate *endTime;
/// 当前时间
@property (nonatomic,strong)NSDate *currentTime;
@end

NS_ASSUME_NONNULL_END
