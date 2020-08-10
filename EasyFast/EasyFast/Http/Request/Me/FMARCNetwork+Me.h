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

- (RACSignal *)uploadImage:(NSInteger)type image:(UIImage *)image;

/// 地址列表
- (RACSignal *)findAddressListPageNum:(NSNumber *)pageNum;
@end

NS_ASSUME_NONNULL_END
