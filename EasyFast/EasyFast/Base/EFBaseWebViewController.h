//
//  EFBaseWebViewController.h
//  EasyFast
//
//  Created by zclee on 2020/7/21.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseWebViewController : EFBaseViewController

@property (nonatomic,strong)WKWebView *webView;
- (instancetype)initWithUrl:(NSString *)url navTitle:(NSString *)title hasNav:(BOOL)show query:(id)query;
- (void)getFun;
@end

NS_ASSUME_NONNULL_END
