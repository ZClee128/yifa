//
//  ShareManager.h
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareManager : NSObject

+ (instancetype)defaultManager;

- (void)showShareViewWithTitle:(NSString *)title shareLink:(NSString *)shareLink sharetext:(NSString *)shareText shareImage:(NSString *)shareImage;
@end

NS_ASSUME_NONNULL_END
