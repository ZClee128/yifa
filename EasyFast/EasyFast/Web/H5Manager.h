//
//  H5Manager.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface H5Manager : NSObject

+ (instancetype)defaultManager;

- (void)gotoUrl:(NSString *)url hasNav:(BOOL)show navTitle:(NSString *)title query:(id)query;
- (NSString *)md5:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
