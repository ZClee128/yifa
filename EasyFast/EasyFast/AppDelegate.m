//
//  AppDelegate.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "AppDelegate.h"
#import "EFOneLoginViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "LoginVM.h"
@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic,strong)BMKMapManager *mapManager;
@end

@implementation AppDelegate

//21227 开发im证书id
//21226 正式im证书id

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FMARCNetwork sharedInstance] setupBaseURL:[FMARCNetwork testURL:[[HttpManager defaultManager] envBaseHost]]];
    // 配置导航栏属性
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
        // 导航栏背景色
        configure.backgroundColor = [UIColor whiteColor];
        // 导航栏标题颜色
        configure.titleColor = tabbarBlackColor;
        // 导航栏标题字体
        configure.titleFont = MedFont17;
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = WidthOfScale(8.5);
        configure.gk_navItemRightSpace = 12.0f;
    }];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.efTabbar = [[EFBaseTabBarViewController alloc] initWithContext:@""];
    self.window.rootViewController = self.efTabbar;
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[EFOneLoginViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
//    im
    [[TUIKit sharedInstance] setupWithAppId:1400405951];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    
    BOOL ret = [_mapManager start:@"brtAQXQtPD73s1j0mycvfeVosv2eRRlX"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
//    数据库日志
    [BGDB shareManager].debug = YES;
    // U-Share 平台设置
//    [self confitUShareSettings];
    [self configUSharePlatforms];
    
//    极光认证
    JVAuthConfig *config = [[JVAuthConfig alloc] init];
    config.appKey = @"dd10c0e76e97072558cf1d77";
    [JVERIFICATIONService setupWithConfig:config];
    [JVERIFICATIONService setDebug:NO];
    
    // 骨架屏
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    [TABAnimated sharedAnimated].openLog = YES;
    [TABAnimated sharedAnimated].openAnimationTag = NO;
    [TABAnimated sharedAnimated].animationType = TABAnimationTypeBinAnimation;
    [TABAnimated sharedAnimated].animatedColor = colorfafafa;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EFCustomWebViewPool *webViewPool = [EFCustomWebViewPool sharedInstance];
        [webViewPool prepareWithCount:10];
        if(![JVERIFICATIONService checkVerifyEnable]) {
            self.isOkOnePhone = NO;
        }else {
            self.isOkOnePhone = YES;
        }
        [JVERIFICATIONService preLogin:5000 completion:^(NSDictionary *result) {
        NSLog(@"登录预取号 result:%@", result);
        }];
    });
    return YES;
}

//- (void)confitUShareSettings
//{
//    /*
//     * 打开图片水印
//     */
//    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
//    /*
//     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
//     <key>NSAppTransportSecurity</key>
//     <dict>
//     <key>NSAllowsArbitraryLoads</key>
//     <true/>
//     </dict>
//     */
//    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
//        //配置微信平台的Universal Links
//    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
//    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/",
//                                                        @(UMSocialPlatformType_QQ):@"https://umplus-sdk-download.oss-cn-shanghai.aliyuncs.com/qq_conn/101830139"
//                                                        };
//    //extraInitDic
//    [UMSocialGlobal shareInstance].extraInitDic = @{
//                                                    @(UMSocialPlatformType_WechatWork):@{@"corpId":@"wwac6ffb259ff6f66a",@"agentId":@"1000002"}
//                                                    };
//}

- (void)configUSharePlatforms
{

    [UMConfigure initWithAppkey:@"5f226944d309322154737f12" channel:@"App Store"];

    /* 设置微信的appKey和appSecret *///
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2456b611d95ac358" appSecret:@"bb7ee5e143ad9e83e8d78c868c4e1892" redirectURL:@"https://www.one-fast.com"];
    [WXApi registerApp:@"wx2456b611d95ac358" universalLink:@"https://www.one-fast.com"];
    /*设置小程序回调app的回调*/
//    [[UMSocialManager defaultManager] setLauchFromPlatform:(UMSocialPlatformType_WechatSession) completion:^(id userInfoResponse, NSError *error) {
//        NSLog(@"setLauchFromPlatform:userInfoResponse:%@",userInfoResponse);
//    }];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1110677743"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"https://www.one-fast.com"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1452254064"  appSecret:@"c70f9d5fbfb686cc8611d49dbaea2b21" redirectURL:@"https://api.one-fast.com/api-client/thrid/weibo/oauth"];
    
}

// 支持所有iOS系统
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
//         // 其他如支付等SDK的回调
//    }
//    return result;
//}
//
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
//    if (!result) {
//         // 其他如支付等SDK的回调
//    }
//    return result;
//}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
         // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"oauth"]){//微信登录
            return [WXApi handleOpenURL:url delegate:self];
        }
    }
    return result;
}


- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (void)onReq:(BaseReq *)req {
    
}

- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *resp2 = (SendAuthResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:kwxLogin object:resp2];
    }else{
        NSLog(@"授权失败");
    }
    
}

@end
