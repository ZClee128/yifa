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

+ (RACSignal *)goodsMonthFootprint {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] goodsMonthFootprint];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] goodsFootprintList:self.dateStr pageNum:self.firstPage];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFootPrint class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] goodsFootprintList:self.dateStr pageNum:@([self.paging intValue] + 1)];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFootPrint class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)uploadImage:(NSInteger)type image:(UIImage *)image {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] uploadImage:type image:@[image]];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

+ (RACSignal *)queryUserInfoCount {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] queryUserInfoCount];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFQueryUserInfoCountModel *model = [EFQueryUserInfoCountModel modelWithJSON:result.reqResult];
        return model;
    }];
}

+ (RACSignal *)queryUserOrderCount {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] queryUserOrderCount];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFQueryUserOrderCountModel *model = [EFQueryUserOrderCountModel modelWithJSON:result.reqResult];
        return model;
    }];
}

+ (RACSignal *)queryUserTeamCount {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] queryUserTeamCount];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFQueryUserTeamCountModel *model = [EFQueryUserTeamCountModel modelWithJSON:result.reqResult];
        return model;
    }];
}
@end
