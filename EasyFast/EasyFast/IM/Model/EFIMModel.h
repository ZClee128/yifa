//
//  EFIMModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFIMModel : EFBaseModel

/// 消息数量
@property (nonatomic,strong)NSString *msgCount;
/// 消息编号
@property (nonatomic,strong)NSString *msgNo;
/// 消息内容
@property (nonatomic,strong)NSString *msgText;
/// 消息链接
@property (nonatomic,strong)NSString *msgUrl;
/// 店铺账号
@property (nonatomic,strong)NSString *shopAccount;
/// 店铺图标
@property (nonatomic,strong)NSString *shopIcon;
/// 店铺名称
@property (nonatomic,strong)NSString *shopName;
/// 店铺编号
@property (nonatomic,strong)NSString *shopNo;
/// 消息类型，1：客服、2：链接
@property (nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
