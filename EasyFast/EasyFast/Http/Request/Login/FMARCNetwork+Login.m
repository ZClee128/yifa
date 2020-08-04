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
    return [self fg_postRequest:kUserLogin paramters:@{@"account":account,@"code":code,@"loginToken":loginToken,@"password":password,@"phone":phone,@"type":@(type)}];
}

- (RACSignal *)userregister:(NSString *)phone code:(NSString *)code {
    return [self fg_postRequest:kRegister paramters:@{@"phone":phone,@"code":code}];
}

- (RACSignal *)sendCode:(NSString *)phone type:(NSInteger)type {
    return [self fg_postRequest:ksendCode paramters:@{@"phone":phone,@"type":@(type)}];
}

- (RACSignal *)verifyMessage:(NSString *)code phone:(NSString *)phone type:(NSInteger)type {
    return [self fg_postRequest:kverifyMessage paramters:@{@"code":code,@"phone":phone,@"type":@(type)}];
}

- (RACSignal *)loginOut {
    return [self fg_postRequest:kLoginOut paramters:@{}];
}
@end
