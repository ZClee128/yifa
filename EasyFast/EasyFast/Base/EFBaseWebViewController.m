//
//  EFBaseWebViewController.m
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "EFBridge.h"
#import "EFH5DownLoadModel.h"
#import "EFPayStatusModel.h"
#import "EFPayStatusViewController.h"
#import "EFOrderViewController.h"

@interface EFBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong)WebViewJavascriptBridge *bridge;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *Webtitle;

@property (nonatomic,strong)EFBridge *efbridge;
@property (nonatomic,assign)BOOL show;
@property (nonatomic,strong)id isShowSKU;
@end

@implementation EFBaseWebViewController

//-(WKWebView *)webView
//{
//    if (_webView == nil) {
//        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) configuration:[[EFWKWebConfig alloc] init]];
//        // UI代理
//        _webView.UIDelegate = self;
//        // 导航代理
//        _webView.navigationDelegate = self;
//        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
//        _webView.allowsBackForwardNavigationGestures = YES;
//        // 开启日志
//        [WebViewJavascriptBridge enableLogging];
//        // 给webview建立JS与OjbC的沟通桥梁
//        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
//        [self.bridge setWebViewDelegate:self];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"pay" ofType:@"html" inDirectory:@"dist"];
//
//        NSURL *fileURL = [NSURL fileURLWithPath:path];
//
//        [_webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
//
//
//    }
//    return _webView;
//}

- (instancetype)initWithUrl:(NSString *)url navTitle:(NSString *)title hasNav:(BOOL)show query:(id)query
{
    self = [super init];
    if (self) {
        self.url = url;
        self.Webtitle = title;
        self.show = show;
        self.isShowSKU = query;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = self.Webtitle;
    self.gk_navigationBar.hidden = !self.show;
    self.webView = [[EFCustomWebViewPool sharedInstance] getWKWebViewFromPool];
    self.webView.frame = CGRectMake(0, self.show ? NAVIGATION_BAR_HEIGHT : 0, SCREEN_WIDTH, SCREEN_HEIGHT- (self.show ? NAVIGATION_BAR_HEIGHT : 0));
    [self.view  addSubview:self.webView];
    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    // 给webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
//
//    if ([kH5Manager isTmpExist]) {
//        NSURL *fileURL = [NSURL fileURLWithPath:[kH5Manager openIndex]];
//        [_webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
//    }else {
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[kH5Manager getModel] ? [kH5Manager getModel].loadingUrl : @"https://api.one-fast.com/"]]];
//    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: @"http://192.168.3.23:8080/"]]];
    [self getFun];
    self.gk_fullScreenPopDisabled = YES;
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kPaySuccessNoti object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        EFPayStatusModel *model = x.object;
        XYLog(@"model>>>>%@",model);
        @strongify(self);
        if (kAppDelegate.isPay) {
            kAppDelegate.isPay = NO;
            if (model.payState == 2) {
                EFPayStatusViewController *vc = [[EFPayStatusViewController alloc] initWithsssNo:kAppDelegate.sssNo ? kAppDelegate.sssNo : @""];
                [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
                    
                }];
            }else {
                if (model.orderType == 1) {
                    EFOrderViewController *order = [[EFOrderViewController alloc] initWithIndex:0];
                    @strongify(self);
                    [self.navigationController qmui_pushViewController:order animated:YES completion:^{
                        NSMutableArray *marr = [[NSMutableArray alloc] initWithArray:[UIViewController getCurrentVC].navigationController.viewControllers];
                        for (UIViewController *vc in marr) {
                            if (![vc isKindOfClass:[[UIViewController getCurrentVC].navigationController.qmui_rootViewController class]]) {
                                [marr removeObject:vc];
                                break;
                            }
                        }
                        [UIViewController getCurrentVC].navigationController.viewControllers = marr;
                    }];
                }else if (model.orderType == 2){
                    [kH5Manager gotoUrl:@"myGroup" hasNav:NO navTitle:@"" query:@{@"index" : @(0)} completion:^{
                        NSMutableArray *marr = [[NSMutableArray alloc] initWithArray:[UIViewController getCurrentVC].navigationController.viewControllers];
                        XYLog(@"$$$$$>>>%@",[UIViewController getCurrentVC].navigationController.qmui_rootViewController);
                        for (UIViewController *vc in marr) {
                            if (![vc isKindOfClass:[[UIViewController getCurrentVC].navigationController.qmui_rootViewController class]]) {
                                [marr removeObject:vc];
                                break;
                            }
                        }
                        [UIViewController getCurrentVC].navigationController.viewControllers = marr;
                    }];
                }else {
                    
                }
            }
        }
    }];
}

- (void)getFun {
    self.efbridge = [[EFBridge alloc] initWithBridge:self.bridge];
    [self.efbridge GetNavHeight];
    [self.efbridge goTo:self.url query:self.isShowSKU];
    [self.efbridge goTuanList];
    [self.efbridge goback];
    [self.efbridge IM];
    [self.efbridge share];
    [self.efbridge Pay];
    [self.efbridge ChooseAddress];
    [self.efbridge Camera];
    [self.efbridge goOrderDetail];
    [self.efbridge goOrderList];
    [self.efbridge evalWritingOver];
    [self.efbridge returnApplyOver];
    [self.efbridge login];
    [self.efbridge recomListClick];
    [self.efbridge tel];
    [self.efbridge TeamListPay];
}


#pragma wkwebview

    // 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
    // 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}
    // 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
    // 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
     
}


@end
