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
#define kupdatePassWord @"api-client/user/info/updatePassWord" // 修改密码

// 关注
#define kfindCollectGoodsList @"api-client/follow/findCollectGoodsList" // 收藏商品列表接口
#define kfindFollowShopList @"api-client/follow/findFollowShopList" // 关注店铺列表接口
#define kfindTransactionShopList @"api-client/follow/findTransactionShopList" //交易过的店铺列表接口
#define kfindTheTeamShopList @"api-client/follow/findTheTeamShopList" //即将成团的店铺列表接口
#define ksetFollowShop @"api-client/follow/setFollowShop" //关注店铺接口
#define kcancelFollowShop @"api-client/follow/cancelFollowShop" //取消关注店铺接口
#define ksetCollectGoods @"api-client/follow/setCollectGoods" //收藏商品接口
#define kcancelCollectGoods @"api-client/follow/cancelCollectGoods" //取消收藏商品接口

// 订单
#define kmyOrderList @"api-client/user/order/myOrderList" //订单接口
#endif /* Api_h */
