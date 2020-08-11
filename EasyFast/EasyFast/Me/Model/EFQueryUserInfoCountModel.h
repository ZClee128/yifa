//
//  EFQueryUserInfoCountModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFQueryUserInfoCountModel : EFBaseModel

/// 关注店铺数量
@property (nonatomic,strong)NSString *followShopCount;
/// 浏览足迹数量
@property (nonatomic,strong)NSString *footprintCount;
/// 我的消息数量
@property (nonatomic,strong)NSString *messageCount;
/// 是否新消息，0：否、1：是
@property (nonatomic,assign)BOOL isNewMessage;
@end

NS_ASSUME_NONNULL_END
