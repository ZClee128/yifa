//
//  EFQueryUserTeamCountModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFQueryUserTeamCountModel : EFBaseModel

/// 我的团购-已失效数量
@property (nonatomic,strong)NSString *failCount;
/// 我的团购-待拼团数量
@property (nonatomic,strong)NSString *pendingPayCount;
/// 我的团购-已完成数量
@property (nonatomic,strong)NSString *successCount;
/// 我的团购-等待中数量
@property (nonatomic,strong)NSString *waitingCount;


@end

NS_ASSUME_NONNULL_END
