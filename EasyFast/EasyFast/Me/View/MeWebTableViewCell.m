//
//  MeWebTableViewCell.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "MeWebTableViewCell.h"

@interface MeWebTableViewCell ()

@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)WebViewJavascriptBridge *bridge;

@end

@implementation MeWebTableViewCell

-(WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:[[EFWKWebConfig alloc] init]];
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        // 开启日志
        [WebViewJavascriptBridge enableLogging];
        // 给webview建立JS与OjbC的沟通桥梁
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [self.bridge setWebViewDelegate:self];
        NSString *hFivePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
            NSURL *url = [NSURL fileURLWithPath:hFivePath];
            
            // 加载方式一
            NSString *htmlString = [NSString stringWithContentsOfFile:hFivePath encoding:NSUTF8StringEncoding error:nil];
            [_webView loadHTMLString:htmlString baseURL:url];

    }
    return _webView;
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


- (void)setUI {
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
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
