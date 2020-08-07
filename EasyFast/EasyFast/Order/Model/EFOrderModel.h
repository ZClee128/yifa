//
//  EFOrderModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

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
/// 订单状态，100：未付款、200：待发货、300：待收货、400：待评价、500：退款/售后
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

@end

NS_ASSUME_NONNULL_END
