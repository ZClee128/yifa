//
//  MeVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFFootPrint.h"
#import "EFQueryUserInfoCountModel.h"
#import "EFQueryUserOrderCountModel.h"
#import "EFQueryUserTeamCountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MeVM : EFBaseRefreshVM

@property (nonatomic,strong)NSString *dateStr;

+ (RACSignal *)updateUserInfo:(NSString *)city headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname province:(NSString *)province sex:(NSInteger)sex type:(NSInteger)type;

+ (RACSignal *)updatePassWord:(NSString *)oldPassword password:(NSString *)password confirmPassword:(NSString *)confirmPassword;

+ (RACSignal *)goodsMonthFootprint;

+ (RACSignal *)uploadImage:(NSInteger)type image:(UIImage *)image;

+ (RACSignal *)queryUserInfoCount;

+ (RACSignal *)queryUserOrderCount;

+ (RACSignal *)queryUserTeamCount;
@end

NS_ASSUME_NONNULL_END
