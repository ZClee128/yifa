//
//  FMARCNetwork+Me.m
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Me.h"

@implementation FMARCNetwork (Me)

- (RACSignal *)updateUserInfo:(NSString *)city headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname province:(NSString *)province sex:(NSInteger)sex type:(NSInteger)type{
    return [self fg_postRequest:kupdateUserInfo paramters:@{@"city":city,@"headImgUrl":headImgUrl,@"nickname":nickname,@"province":province,@"sex":@(sex),@"type":@(type)}];
}

- (RACSignal *)updatePassWord:(NSString *)oldPassword password:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [self fg_postRequest:kupdatePassWord paramters:@{@"oldPassword":oldPassword.md5,@"password":password.md5,@"confirmPassword":confirmPassword.md5}];
}
@end