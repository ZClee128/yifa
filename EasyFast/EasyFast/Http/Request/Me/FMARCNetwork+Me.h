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

- (RACSignal *)myMessageListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize shopName:(NSString *)shopName;

- (RACSignal *)helpCenterListPageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize title:(NSString *)title;


/// 记录商品日志接口
/// @param type 商品日志分类，1：搜索商品；2：浏览商品
/// @param category 商品分类
/// @param goodsNo 商品编号
/// @param searchText 商品搜索文本
- (RACSignal *)recordGoodsLogType:(NSInteger )type category:(NSString *)category goodsNo:(NSString *)goodsNo searchText:(NSString *)searchText;
@end

NS_ASSUME_NONNULL_END
