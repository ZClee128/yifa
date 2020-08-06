//
//  MeVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "MeVM.h"

@implementation MeVM

+ (RACSignal *)updateUserInfo:(NSString *)city headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname province:(NSString *)province sex:(NSInteger)sex type:(NSInteger)type {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] updateUserInfo:city headImgUrl:headImgUrl nickname:nickname province:province sex:sex type:type];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return @(result.isSuccess);
    }];
}

+ (RACSignal *)updatePassWord:(NSString *)oldPassword password:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] updatePassWord:oldPassword password:password confirmPassword:confirmPassword];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        if (result.isSuccess) {
            for (EFUserModel *model in [EFUserModel bg_findAll:nil]) {
                if ([model.username isEqualToString:kUserManager.userModel.username]) {
                    model.isPassword = 0;
                    [model bg_saveOrUpdate];
                }
            }
        }
        return @(result.isSuccess);
    }];
}

@end
