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

@interface EFBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong)WebViewJavascriptBridge *bridge;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *Webtitle;
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

- (instancetype)initWithUrl:(NSString *)url navTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.url = url;
        self.Webtitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = self.Webtitle;
    self.webView = [[EFCustomWebViewPool sharedInstance] getWKWebViewFromPool];
    self.webView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT);
    [self.view  addSubview:self.webView];
    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    // 给webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.3.23:8080/pay.html"]]]];
//    NSString *path = [[NSBundle mainBundle] pathForResource:self.url ofType:@"html" inDirectory:@"dist"];
//
//    NSURL *fileURL = [NSURL fileURLWithPath:path];

//    [_webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    [self getFun];
}

- (void)getFun {
    EFBridge *bridge = [[EFBridge alloc] initWithBridge:self.bridge];
    [bridge GetNavHeight];
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
