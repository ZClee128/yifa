//
//  ShareManager.m
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "ShareManager.h"

@implementation ShareManager


+ (instancetype)defaultManager {
    static ShareManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [ShareManager new];
    });
    return _sharedManager;
}

- (void)showShareView {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
     [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
}
@end
