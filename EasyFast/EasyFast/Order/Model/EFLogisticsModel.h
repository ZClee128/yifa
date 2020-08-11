//
//  EFLogisticsModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpressItemModel : EFBaseModel

/// 内容
@property (nonatomic,strong)NSString *context;
/// 时间
@property (nonatomic,strong)NSString *time;
/// 格式化时间
@property (nonatomic,strong)NSString *formatTime;
@end


@interface EFLogisticsModel : EFBaseModel

/// 快递单号
@property (nonatomic,strong)NSString *expressNum;
/// 快递状态
@property (nonatomic,strong)NSString *expressState;
/// 快递公司
@property (nonatomic,strong)NSString *expressTitle;
/// 订单编号
@property (nonatomic,strong)NSString *orderNum;
/// 收货地址
@property (nonatomic,strong)NSString *recipientAddress;
/// 快递明细
@property (nonatomic,strong)NSArray<ExpressItemModel *> *expressItemList;
@end

NS_ASSUME_NONNULL_END
