//
//  LoginVM.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFH5DownLoadModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginVM : EFBaseRefreshVM

/// 短信类型(1：登录；2：注册APP；3：注册成为商家；4：找回密码；5：解绑手机；6：绑定手机；)
- (void)getCodeWithBtn:(QMUIButton *)codeBtn withType:(NSInteger)type phone:(NSString *)phone;

+ (RACSignal *)userLogin:(NSString *)account code:(NSString *)code loginToken:(NSString *)loginToken password:(NSString *)password phone:(NSString *)phone type:(NSInteger)type;

+ (RACSignal *)userregister:(NSString *)phone code:(NSString *)code;

+ (RACSignal *)loginOut;

// 解绑
+ (RACSignal *)unbindPhone:(NSString *)phone code:(NSString *)code;

/// 绑定手机 (逻辑已废弃)
+ (RACSignal *)bindingPhone:(NSString *)phone type:(NSInteger)type loginToken:(NSString *)loginToken code:(NSString *)code verifyToken:(NSString *)verifyToken oldPhone:(NSString *)oldPhone;

/// 验证短信
+ (RACSignal *)verifyMessage:(NSString *)code phone:(NSString *)phone type:(NSInteger)type;

+ (RACSignal *)thirdLoginType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid;

+ (RACSignal *)thirdLoginBindingMessage:(NSString *)code phone:(NSString *)phone;


+ (RACSignal *)bindingWechatType:(NSInteger)type city:(NSString *)city province:(NSString *)province headImgUrl:(NSString *)headImgUrl nickname:(NSString *)nickname openid:(NSString *)openid  sex:(NSInteger)sex uid:(NSString *)uid unionid:(NSString *)unionid;

+ (RACSignal *)setNewPasswordNewPassword:(NSString *)password confirmPassword:(NSString *)confirmPassword code:(NSString *)code phone:(NSString *)phone;

+ (RACSignal *)downloadWebPage;

/// 本地清除
+ (void)deletLoction;

+ (void)loginIM:(NSString *)userId sig:(NSString *)sig;
+ (void)loginOutIM;
@end

NS_ASSUME_NONNULL_END
