//
//  EFWxLoginManager.h
//  EasyFast
//
//  Created by easyfast on 2020/8/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EFWxLoginManager : NSObject

+ (instancetype)defaultManager;
// 1 登录，2 绑定
- (void)wxLogin:(NSNotification*)noti withType:(NSInteger)type;
-(void)sendAuthRequest;
@end

NS_ASSUME_NONNULL_END
