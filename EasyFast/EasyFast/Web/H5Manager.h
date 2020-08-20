//
//  H5Manager.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFH5DownLoadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface H5Manager : NSObject

+ (instancetype)defaultManager;

- (void)gotoUrl:(NSString *)url hasNav:(BOOL)show navTitle:(NSString *)title query:(id)query;
- (NSString *)md5:(NSString *)str;

- (void)downloadZipWithUrl:(NSString *)zipurl;
- (NSString *)openIndex;
- (BOOL)isExist;
- (EFH5DownLoadModel *)getModel;
- (void)deletFile;

@end

NS_ASSUME_NONNULL_END
