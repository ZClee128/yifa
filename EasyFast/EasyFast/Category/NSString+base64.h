//
//  NSString+base64.h
//  EasyFast
//
//  Created by easyfast on 2020/8/5.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (base64)

/// 加密
-(NSString *)base64EncodeString;

/// 解密
-(NSString *)base64DecodeString;

- (NSString *)md5;

/// 密码规则
- (BOOL)deptNumInputShouldNumber;

/// 是否中文
- (BOOL)isChinese;
@end

NS_ASSUME_NONNULL_END
