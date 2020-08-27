//
//  AppDelegate.h
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFBaseTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)EFBaseTabBarViewController *efTabbar;
@property (nonatomic,assign) BOOL  isOkOnePhone;
@property (nonatomic,assign) BOOL  isOneBindPhone; //首次绑定
@property (nonatomic,strong) NSString  *BindPhoneUid; // 三方登陆首次用户名
@property (nonatomic,strong)id classCode; // 分类一级
@property (nonatomic,assign) BOOL isPay; // 是否支付回调
@property (nonatomic,strong) NSString *orderNum; // 订单号
@property (nonatomic,strong)NSString *sssNo; //支付成功页面需要的店铺编号
@property (nonatomic,assign) NSInteger payMethod; // 支付方式，1：wx，2：ali，3：unionpay；默认1：微信
@property (nonatomic,assign)BOOL isOut; //401退出标志
@property (nonatomic,assign)BOOL isPayOverNoti; //订单列表支付通知回调
@property (nonatomic,assign)BOOL isGoToRoot; //h5回到根页面

- (UIViewController *)nextRootViewController:(BOOL)bootPage;
@end

