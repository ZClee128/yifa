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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EFCustomWebViewPool *webViewPool = [EFCustomWebViewPool sharedInstance];
        [webViewPool prepareWithCount:10];
    });
    return YES;
}




@end
