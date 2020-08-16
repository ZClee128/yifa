//
//  FMARCNetwork+Login.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Login.h"

@implementation FMARCNetwork (Login)

- (RACSignal *)userLogin:(NSString *)account code:(NSString *)code loginToken:(NSString *)loginToken password:(NSString *)password phone:(NSString *)phone type:(NSInteger)type {
    return [self fg_postRequest:kUserLogin paramters:@{@"account":account,@"code":code,@"loginToken":loginToken,@"password":password.md5,@"phone":phone,@"type":@(type)}];
}

- (RACSignal *)userregister:(NSString *)phone code:(NSString *)code {
    return [self fg_getRequest:kRegister paramters:@{@"phone":phone,@"code":code}];
}

- (RACSignal *)sendCode:(NSString *)phone type:(NSInteger)type {
    return [self fg_getRequest:ksendCode paramters:@{@"phone":phone,@"type":@(type)}];
}

- (RACSignal *)verifyMessage:(NSString *)code phone:(NSString *)phone type:(NSInteger)type {
    return [self fg_getRequest:kverifyMessage paramters:@{@"code":code,@"phone":phone,@"type":@(type)}];
}

- (RACSignal *)loginOut {
    return [self fg_postRequest:kLoginOut paramters:@{}];
}

- (RACSignal *)unbindPhone:(NSString *)phone code:(NSString *)code {
    return [self fg_getRequest:kunbindPhone paramters:@{@"phone":phone,@"code":code}];
}

- (RACSignal *)bindingPhone:(NSString *)phone type:(NSInteger)type loginToken:(NSString *)loginToken code:(NSString *)code verifyToken:(NSString *)verifyToken oldPhone:(NSString *)oldPhone {
    return [self fg_postRequest:kbindingPhone paramters:@{@"phone":phone,@"type":@(type),@"loginToken":loginToken,@"code":code,@"verifyToken":verifyToken,@"oldPhone":oldPhone}];
}

- (RACSignal *)thirdLoginType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid {
    return [self fg_postRequest:kthirdLogin paramters:@{@"type":@(type),@"city":city,@"province":province,@"headImgUrl":headImgUrl,@"nickname":nickname,@"openid":openid,@"sex":@(sex),@"uid":uid,@"unionid":unionid}];
}

- (RACSignal *)thirdLoginBindingMessage:(NSString *)code phone:(NSString *)phone {
    return [self fg_getRequest:kthirdLoginBinding paramters:@{@"code":code,@"phone":phone,@"username":kAppDelegate.BindPhoneUid}];
}

- (RACSignal *)bindingWechatType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid {
    return [self fg_postRequest:kbindingWechat paramters:@{@"type":@(type),@"city":city,@"province":province,@"headImgUrl":headImgUrl,@"nickname":nickname,@"openid":openid,@"sex":@(sex),@"uid":uid,@"unionid":unionid}];
}

- (RACSignal *)setNewPasswordNewPassword:(NSString *)password confirmPassword:(NSString *)confirmPassword {
    return [self fg_postRequest:ksetNewPassword paramters:@{@"password":password,@"confirmPassword":confirmPassword}];
}
@end
