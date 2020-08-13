//
//  EFTeamGoodsModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFTeamGoodsModel : EFBaseModel

/// 当前拼团人数
@property (nonatomic,strong)NSString *currentTeamSize;
/// 商品编码
@property (nonatomic,strong)NSString *ggNo;
/// 商品图片
@property (nonatomic,strong)NSString *image;
/// 商品-起批量
@property (nonatomic,strong)NSString *miniOrderQuantity;
/// 最低价
@property (nonatomic,assign)CGFloat miniPrice;
/// 商家编码
@property (nonatomic,strong)NSString *ssNo;
/// 店铺编码
@property (nonatomic,strong)NSString *sssNo;
/// 当前库存
@property (nonatomic,strong)NSString *stock;
/// 商品名称
@property (nonatomic,strong)NSString *title;

@end

NS_ASSUME_NONNULL_END
