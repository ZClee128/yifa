//
//  AppDelegate.m
//  EasyFast
//
//  Created by zclee on 2020/7/9.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "AppDelegate.h"
#import "EFBaseTabBarViewController.h"
#import "EFOneLoginViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
@interface AppDelegate ()

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
    self.window.rootViewController = [[EFBaseTabBarViewController alloc] initWithContext:@""];
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
    
    // U-Share 平台设置
//    [self confitUShareSettings];
    [self configUSharePlatforms];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EFCustomWebViewPool *webViewPool = [EFCustomWebViewPool sharedInstance];
        [webViewPool prepareWithCount:10];
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
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
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
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1110677743"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
         // 其他如支付等SDK的回调
    }
    return result;
}
@end
