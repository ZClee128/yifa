//
//  EFWKWebConfig.m
//  EasyFast
//
//  Created by zclee on 2020/7/17.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFWKWebConfig.h"

@implementation EFWKWebConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConfig];
    }
    return self;
}

- (void)setConfig {
    // 创建设置对象
     WKPreferences *preference = [[WKPreferences alloc]init];
     //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
     preference.minimumFontSize = 0;
     //设置是否支持javaScript 默认是支持的
     preference.javaScriptEnabled = YES;
     // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
     preference.javaScriptCanOpenWindowsAutomatically = YES;
     self.preferences = preference;
     
     // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
     self.allowsInlineMediaPlayback = YES;
     //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
     self.requiresUserActionForMediaPlayback = YES;
     //设置是否允许画中画技术 在特定设备上有效
     self.allowsPictureInPictureMediaPlayback = YES;
     //设置请求的User-Agent信息中应用程序名称 iOS9后可用
//     self.applicationNameForUserAgent = @"ChinaDailyForiPad";
}

@end
