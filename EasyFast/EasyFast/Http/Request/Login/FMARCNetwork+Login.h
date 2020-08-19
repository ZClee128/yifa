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

/// 短信类型(1：登录；2：注册APP；3：注册成为商家；4：找回密码；5：解绑手机；6：绑定手机；7:首次绑定)
- (RACSignal *)sendCode:(NSString *)phone type:(NSInteger)type;

/// 短信类型(1：登录；2：注册APP；3：注册成为商家；4：找回密码；5：解绑手机；6：绑定手机；) 验证
- (RACSignal *)verifyMessage:(NSString *)code phone:(NSString *)phone type:(NSInteger)type;

/// 退出登录
- (RACSignal *)loginOut;

/// 解绑手机
- (RACSignal *)unbindPhone:(NSString *)phone code:(NSString *)code;

/// 绑定手机
- (RACSignal *)bindingPhone:(NSString *)phone type:(NSInteger)type loginToken:(NSString *)loginToken code:(NSString *)code verifyToken:(NSString *)verifyToken oldPhone:(NSString *)oldPhone;


/// 第三方登录接口
/// @param type 第三方登录类型，1：微信、2：QQ、3：新浪、4：ios
/// @param city 城市
/// @param province 省份
/// @param headImgUrl 头像
/// @param nickname 昵称
/// @param openid 微信或QQ的openid
/// @param sex 性别，1：男；2：女；3：未知
/// @param uid 用户标识
/// @param unionid 微信或QQ的unionid
- (RACSignal *)thirdLoginType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid;


/// 首次绑定接口
/// @param code 验证码
/// @param phone 手机号
- (RACSignal *)thirdLoginBindingMessage:(NSString *)code phone:(NSString *)phone;

/// 绑定微信号接口
/// @param type 第三方登录类型，1：微信、2：QQ、3：新浪、4：ios
/// @param city 城市
/// @param province 省份
/// @param headImgUrl 头像
/// @param nickname 昵称
/// @param openid 微信或QQ的openid
/// @param sex 性别，1：男；2：女；3：未知
/// @param uid 用户标识
/// @param unionid 微信或QQ的unionid
- (RACSignal *)bindingWechatType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid;


- (RACSignal *)setNewPasswordNewPassword:(NSString *)password confirmPassword:(NSString *)confirmPassword;


- (RACSignal *)queryVersion;

- (RACSignal *)downloadWebPage;
@end

NS_ASSUME_NONNULL_END
