//
//  Api.h
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#ifndef Api_h
#define Api_h

//登陆
#define kUserLogin  @"api-client/user/index/login"
#define kRegister @"api-client/user/index/register" //注册
#define ksendCode @"api-client/sms/sendUserMessage" //发送验证码
#define kverifyMessage @"api-client/user/verifyMessage" //验证短信
#define kLoginOut @"api-client/user/loginOut" //退出接口
#define kupdateUserInfo @"api-client/user/info/updateUserInfo" //修改个人信息接口
#define kunbindPhone @"api-client/user/info/unbindPhone" //解绑
#define kbindingPhone @"api-client/user/info/bindingPhone" //绑定手机
#endif /* Api_h */
