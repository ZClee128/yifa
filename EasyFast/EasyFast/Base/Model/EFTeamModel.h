//
//  EFTeamModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFTeamOrderDtoListModel : EFBaseModel
/// 发起/参团时间
@property (nonatomic,assign)double createDate;
/// 团员头像
@property (nonatomic,strong)NSString *headImgUrl;
/// 团员昵称
@property (nonatomic,strong)NSString *nickName;
/// 团编码
@property (nonatomic,assign)NSInteger ootNo;
/// 购买量
@property (nonatomic,assign)NSInteger quantity;
@end



@interface EFTeamModel : EFBaseModel

/// 过期时间
@property (nonatomic,assign)double expireDate;
/// 商品编码
@property (nonatomic,strong)NSString *ggNo;
@property (nonatomic,strong)NSString *groupMethod;
/// 拼团的team编码
@property (nonatomic,strong)NSString *ootNo;
/// 当前购买量
@property (nonatomic,assign)NSInteger purchaseQuantity;
/// 拼团状态，0：初始化（团长刚下单未支付）1：待成团:2：未成团(拼团失败)，3：已成团
@property (nonatomic,assign)NSInteger state;
/// 成团量
@property (nonatomic,assign)NSInteger successQuantity;
/// 团长昵称
@property (nonatomic,strong)NSString *teamLeaderName;
/// 团长头像地址
@property (nonatomic,strong)NSString *teamLeaderUrl;
/// 拼团进度
@property (nonatomic,assign)CGFloat teamProcess;
@property (nonatomic,strong)NSArray<EFTeamOrderDtoListModel *> *teamOrderDtoList;
@end

NS_ASSUME_NONNULL_END
