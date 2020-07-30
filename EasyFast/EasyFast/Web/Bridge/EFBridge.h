//
//  EFBridge.h
//  EasyFast
//
//  Created by easyfast on 2020/7/28.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFBridge : NSObject

- (instancetype)initWithBridge:(WebViewJavascriptBridge *)bridge;

// 获取导航栏高度
- (void)GetNavHeight;
// 获取我的页面底部列表高度
- (RACSignal *)getMeListHeight;
@end

NS_ASSUME_NONNULL_END