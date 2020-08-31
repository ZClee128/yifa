//
//  MeWebTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "MeWebTableViewCell.h"
#import "EFBridge.h"

@interface MeWebTableViewCell ()

@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)WKWebViewJavascriptBridge *bridge;
@property (nonatomic,strong)EFBridge *efbridge;

@end

@implementation MeWebTableViewCell

//-(WKWebView *)webView
//{
//    if (_webView == nil) {
//        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:[[EFWKWebConfig alloc] init]];
//        // UI代理
//        _webView.UIDelegate = self;
//        // 导航代理
//        _webView.navigationDelegate = self;
//        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
//        _webView.allowsBackForwardNavigationGestures = YES;
//
//
//    }
//    return _webView;
//}


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


- (void)setUI {
    self.webView = [[EFCustomWebViewPool sharedInstance] getWKWebViewFromPool];
    self.webView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    // 开启日志
//    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView showJSconsole:YES enableLogging:YES];
    [WKWebViewJavascriptBridge enableLogging];
    // 给webview建立JS与OjbC的沟通桥梁
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    self.efbridge = [[EFBridge alloc] initWithBridge:self.bridge];
    [self.bridge setWebViewDelegate:self];
    if ([kH5Manager isExist]) {
        if ([[kH5Manager openIndex] isEqualToString:@""] || [kH5Manager openIndex] == nil) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[kH5Manager getModel] ? [kH5Manager getModel].loadingUrl : @"https://api.one-fast.com/"]]];
            return;
        }
        NSURL *fileURL = [NSURL fileURLWithPath:[kH5Manager openIndex]];
        [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    }else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[kH5Manager getModel] ? [kH5Manager getModel].loadingUrl : @"https://api.one-fast.com/"]]];
    }
    [self.bridge callHandler:@"goTo" data:@{@"page":@"recom",@"query":@{},} responseCallback:^(id responseData) {

    }];
    
    [self.efbridge recomListClick];
    
}

- (RACSignal *)getCellHeight {
    
    return [self.efbridge getMeListHeight];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
