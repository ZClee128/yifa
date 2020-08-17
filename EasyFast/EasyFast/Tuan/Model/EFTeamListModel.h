//
//  EFTeamListModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamOrderDtoModel : EFBaseModel

/// 发起/参团时间
@property (nonatomic,strong)NSDate *createDate;
/// 团员头像
@property (nonatomic,strong)NSString *headImgUrl;
/// 团员昵称
@property (nonatomic,strong)NSString *nickName;
/// 团编码
@property (nonatomic,strong)NSString *ootNo;
/// 购买量
@property (nonatomic,strong)NSString *quantity;
@end


@interface EFTeamListModel : EFBaseModel

/// 拼团开始时间
@property (nonatomic,strong)NSDate *createDate;
/// 服务器当前时间
@property (nonatomic,strong)NSDate *currentDate;
/// 到期时间
@property (nonatomic,strong)NSDate *expireDate;
/// 商品编码
@property (nonatomic,strong)NSString *ggNo;
/// 拼团方式
@property (nonatomic,strong)NSString *groupMethod;
/// 拼团的team编码
@property (nonatomic,strong)NSString *ootNo;
/// 当前购买量
@property (nonatomic,strong)NSString *purchaseQuantity;
/// 店铺编码
@property (nonatomic,strong)NSString *sssNo;
/// 拼团状态，0：初始化（团长刚下单未支付）1：待成团:2：未成团(拼团失败)，3：已成团
@property (nonatomic,assign)NSInteger state;
/// 成团量
@property (nonatomic,strong)NSString *successQuantity;
/// 团长昵称
@property (nonatomic,strong)NSString *teamLeaderName;
/// 团长头像地址
@property (nonatomic,strong)NSString *teamLeaderUrl;
/// 拼团进度
@property (nonatomic,assign)CGFloat teamProcess;
/// 拼团成功时间
@property (nonatomic,strong)NSDate *teamSuccessDate;

@property (nonatomic,strong)NSArray<TeamOrderDtoModel *> *teamOrderDtoList;

@end

NS_ASSUME_NONNULL_END
