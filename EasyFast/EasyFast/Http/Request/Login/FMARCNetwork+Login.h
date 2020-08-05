//
//  FMARCNetwork+Login.h
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (Login)

// 登陆
- (RACSignal *)userLogin:(NSString *)account code:(NSString *)code loginToken:(NSString *)loginToken password:(NSString *)password phone:(NSString *)phone type:(NSInteger)type;

// 注册
- (RACSignal *)userregister:(NSString *)phone code:(NSString *)code;

/// 短信类型(1：登录；2：注册APP；3：注册成为商家；4：找回密码；5：解绑手机；6：绑定手机；)
- (RACSignal *)sendCode:(NSString *)phone type:(NSInteger)type;

/// 短信类型(1：登录；2：注册APP；3：注册成为商家；4：找回密码；5：解绑手机；6：绑定手机；) 验证
- (RACSignal *)verifyMessage:(NSString *)code phone:(NSString *)phone type:(NSInteger)type;

/// 退出登录
- (RACSignal *)loginOut;

/// 解绑手机
- (RACSignal *)unbindPhone:(NSString *)phone code:(NSString *)code;

/// 绑定手机
- (RACSignal *)bindingPhone:(NSString *)phone type:(NSInteger)type loginToken:(NSString *)loginToken code:(NSString *)code verifyToken:(NSString *)verifyToken oldPhone:(NSString *)oldPhone;
@end

NS_ASSUME_NONNULL_END
