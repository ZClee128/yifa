//
//  EFIMModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"
#import "EFMsgBody.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFIMModel : EFBaseModel

/// 未读消息数量
@property (nonatomic,strong)NSString *unRead;
/// 最后会话时间yyyy-MM-dd HH:mm:ss
@property (nonatomic,strong)NSString *updateTime;
/// 会话更新时间戳毫秒值
@property (nonatomic,strong)NSString *updateTimeMills;
/// 商家Im账号UserID
@property (nonatomic,strong)NSString *ssuNo;
/// 商家编号
@property (nonatomic,strong)NSString *ssNo;
/// 店铺图标
@property (nonatomic,strong)NSString *sssIcon;
/// 店铺名称
@property (nonatomic,strong)NSString *sssTitle;
/// 店铺编号
@property (nonatomic,strong)NSString *sssNo;
/// 消息类型，1：客服、2：链接
@property (nonatomic,assign)NSInteger type;
/// 商家账号昵称
@property (nonatomic,strong)NSString *ssuNickName;
/// 客户Im账号UserID
@property (nonatomic,strong)NSString *uuNo;
/// 最后一次会话消息体
@property (nonatomic,strong)NSArray<EFMsgBody *> *msgBody;
@end

NS_ASSUME_NONNULL_END
