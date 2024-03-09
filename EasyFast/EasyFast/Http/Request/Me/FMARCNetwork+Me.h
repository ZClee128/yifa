//
//  FMARCNetwork+Me.h
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Me)

/// 修改类型为 1：头像、2：昵称、3：性别、4：地区
- (RACSignal *)updateUserInfo:(NSString *)city headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname province:(NSString *)province sex:(NSInteger)sex type:(NSInteger)type;

/// 修改密码
- (RACSignal *)updatePassWord:(NSString *)oldPassword password:(NSString *)password confirmPassword:(NSString *)confirmPassword;

/// 商品当月足迹接口
- (RACSignal *)goodsMonthFootprint;

/// 商品足迹列表接口
- (RACSignal *)goodsFootprintList:(NSString *)queryTime pageNum:(NSNumber *)pageNum;

- (RACSignal *)uploadImage:(NSInteger)type image:(NSArray *)image;

/// 地址列表
- (RACSignal *)findAddressListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;

/// 新增地址
- (RACSignal *)addAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area;

/// 删除地址
- (RACSignal *)delAddress:(NSString *)addressNo;

/// 设置默认
- (RACSignal *)setDefaultAddress:(NSString *)addressNo;

/// 修改地址
- (RACSignal *)updateAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area addressNo:(NSString *)addressNo;

/// 我的信息数量接口
- (RACSignal *)queryUserInfoCount;

- (RACSignal *)queryUserOrderCount;

- (RACSignal *)queryUserTeamCount;

- (RACSignal *)myMessageListshopName:(NSString *)shopName;

- (RACSignal *)helpCenterListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize title:(NSString *)title;


/// 记录商品日志接口
/// @param type 商品日志分类，1：搜索商品；2：浏览商品
/// @param category 商品分类
/// @param goodsNo 商品编号
/// @param searchText 商品搜索文本
- (RACSignal *)recordGoodsLogType:(NSInteger )type category:(NSString *)category goodsNo:(NSString *)goodsNo searchText:(NSString *)searchText;

- (RACSignal *)queyMessageRemind;



/// 设置消息提醒接口
/// @param type 修改类型为 1：消息通知时间、2：新消息提醒、3：声音提醒、4：震动提醒
/// @param endTime 通知结束时间
/// @param startTime 通知开始时间
/// @param isMessageRemind 是否消息提醒
/// @param isVibrationRemind 是否震动提醒
/// @param isVoiceRemind 是否声音提醒
- (RACSignal *)messageRemindType:(NSInteger )type endTime:(NSString *)endTime startTime:(NSString *)startTime isMessageRemind:(BOOL)isMessageRemind isVibrationRemind:(BOOL)isVibrationRemind isVoiceRemind:(BOOL)isVoiceRemind;


/// IM 生成userSig
- (RACSignal *)genUserSig;


/// IM 消息已读
/// @param userId 对方的IM账号
- (RACSignal *)msgReaduserId:(NSString *)userId;


/// IM 生成会话,创建成功返回会话id
/// @param toAccount 对方的IM编码
- (RACSignal *)createSessiontoAccount:(NSString *)toAccount;


/// 分页查询历史消息列表
/// @param dateTimeMills 起始时间戳，单位为毫秒
/// @param userId 对方的IM账号
/// @param pageSize 消息数量
- (RACSignal *)pageMsgHistoryDateTimeMills:(NSString *)dateTimeMills userId:(NSString *)userId pageSize:(NSNumber *)pageSize;
@end

NS_ASSUME_NONNULL_END
