//
//  EFFollowModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"
#import "EFGoodsList.h"
#import "EFTeamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FollowTeamModel : EFBaseModel

/// 开团时间
@property (nonatomic,strong)NSDate *createDate;
/// 过期时间
@property (nonatomic,strong)NSDate *expireDate;
/// 拼团编码
@property (nonatomic,strong)NSString *ootNo;
/// 团长昵称
@property (nonatomic,strong)NSString *teamLeaderName;
/// 团长头像地址
@property (nonatomic,strong)NSString *teamLeaderUrl;
/// 拼团进度
@property (nonatomic,assign)CGFloat teamProcess;

@end


@interface EFFollowModel : EFBaseModel

@property (nonatomic,strong)NSString *city;
@property (nonatomic,assign)NSInteger followNum;
@property (nonatomic,assign)BOOL isFollow;
@property (nonatomic,strong)NSString *lookBackRate;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *shopIcon;
@property (nonatomic,strong)NSString *shopName;
@property (nonatomic,strong)NSString *shopNo;
@property (nonatomic,strong)NSArray *shopTagList;
@property (nonatomic,strong)NSArray<EFGoodsList *> *goodsList;
@property (nonatomic,strong)FollowTeamModel *team;
@end

NS_ASSUME_NONNULL_END
