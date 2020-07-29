//
//  EFCustomWebViewPool.h
//  EasyFast
//
//  Created by easyfast on 2020/7/28.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFCustomWebViewPool : NSObject

+ (instancetype)sharedInstance;

/**
 预初始化若干WKWebView
 @param count 个数
 */
- (void)prepareWithCount:(NSUInteger)count;

/**
 从池中获取一个WKWebView
 
 @return WKWebView
 */

- (WKWebView *)getWKWebViewFromPool;

@end

NS_ASSUME_NONNULL_END
