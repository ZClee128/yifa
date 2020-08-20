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
#define kverifyMessage @"api-client/sms/verifyMessage" //验证短信
#define kLoginOut @"api-client/user/loginOut" //退出接口
#define kthirdLogin @"api-client/user/index/thirdLogin" //第三方登录接口
#define kupdateUserInfo @"api-client/user/info/updateUserInfo" //修改个人信息接口
#define kunbindPhone @"api-client/user/info/unbindPhone" //解绑
#define kbindingPhone @"api-client/user/info/bindingPhone" //绑定手机
#define kupdatePassWord @"api-client/user/info/updatePassWord" // 修改密码
#define kthirdLoginBinding @"api-client/user/index/thirdLoginBinding" //首次绑定接口
#define kbindingWechat @"api-client/user/info/bindingWechat" //绑定微信号接口
#define ksetNewPassword @"api-client/user/info/setNewPassword" //设置新密码接口

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
#define kmyOrderSearchList @"api-client/user/order/myOrderSearchList" //订单搜索列表接口
#define kmyOrderDetail @"api-client/user/order/myOrderDetail" //订单明细接口
#define kconfirmReceipt @"api-client/user/order/confirmReceipt" //确认收货接口
#define kurgedDelivery @"api-client/user/order/urgedDelivery" //催促发货接口
#define korderExpress @"api-client/user/order/orderExpress" //订单物流接口
#define krefreshOrder @"api-client/order/refreshOrder" //查询订单支付状态,0:待支付，1：支付成功

// 我的
#define kgoodsMonthFootprint @"api-client/user/footprint/goodsMonthFootprint" //商品当月足迹接口
#define kgoodsFootprintList @"api-client/user/footprint/goodsFootprintList" //商品足迹列表接口
#define kuploadImage @"api-client/file/uploadImage" // 上传图片
#define kfindAddressList @"api-client/user/address/findAddressList" // 地址列表接口
#define kaddAddress @"api-client/user/address/addAddress" //新增地址接口
#define kdelAddress @"api-client/user/address/delAddress" //删除地址接口
#define ksetDefaultAddress @"api-client/user/address/setDefaultAddress" //设置默认地址
#define kupdateAddress @"api-client/user/address/updateAddress" // 修改收货地址
#define kqueryUserInfoCount @"api-client/user/info/queryUserInfoCount" //我的信息数量接口
#define kqueryUserOrderCount @"api-client/user/info/queryUserOrderCount" // 我的订单数量接口
#define kqueryUserTeamCount @"api-client/user/info/queryUserTeamCount" // 我的团购数量接口
#define kmyMessageList @"api-client/user/message/myMessageList" //我的消息列表接口
#define khelpCenterList @"api-client/user/help/helpCenterList" // 帮助中心
#define krecordGoodsLog @"api-client/user/log/recordGoodsLog" //记录商品日志接口
#define kmessageRemind @"api-client/user/set/messageRemind" //消息提醒
#define kqueyMessageRemind @"api-client/user/set/queyMessageRemind" //查看消息提醒设置接口
#define kmessageRemind @"api-client/user/set/messageRemind" // 设置消息提醒接口

// 首页
#define kactivity @"api-client/index/activity" // 查询活动信息
#define kbanner @"api-client/index/banner" // 查询banner信息
#define knotice @"api-client/index/notice" // 查询公告信息
#define khome @"api-client/goods/home" // 首页-企业批发
#define kpageGoodsByCategory @"api-client/goods/pageGoodsByCategory" // 根据商家分类编码查询商品列表
#define kpageShopNewGoods @"api-client/goods/pageShopNewGoods" // 店铺新品
#define kfast @"api-client/team/fast" //急速拼团
#define kpageTeam @"api-client/team/pageTeam" //急速拼团列表
#define kgetSearchHistoryList @"api-client/index/getSearchHistoryList" //首页搜索-获取搜索历史
#define ksearchGoodsList @"api-client/index/searchGoodsList" //首页搜索-搜索商品列表
#define kpageTeamByGoodsNo @"api-client/team/pageTeamByGoodsNo" //分页查询商品的拼团列表
#define kgoodsSummary @"api-client/goods/goodsSummary" //根据商品编码查询商品摘要-拼团列表用
#define kteamInfo @"api-client/team/teamInfo" //拼团团员详情

// 分类
#define kcategory @"api-client/platform/category/category" //APP端商品分类-所有
#define kcategoryByPno @"api-client/platform/category/categoryByPno" ///根据APP端父级代码code查询APP端下级分类,pCode为0时获取一级标签
#define kthirdCategory @"api-client/platform/category/thirdCategory" // 根据一级分类查询三级分类
#define kpageTeamByGoodsNo @"api-client/team/pageTeamByGoodsNo" //分页查询商品的拼团列表


// app
#define kqueryVersion @"api-client/app/queryAppVersion" //查询APP版本接口
#define kdownloadWebPage @"api-client/app/queryAppWebVersion" // 下载网页包接口
#endif /* Api_h */
