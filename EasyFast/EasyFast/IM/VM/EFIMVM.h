//
//  EFIMVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFIMModel.h"
#import "EFMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFIMVM : EFBaseRefreshVM

@property (nonatomic,strong)NSString *shopName;

+ (RACSignal *)genUserSig;

+ (RACSignal *)msgReaduserId:(NSString *)userId;

+ (RACSignal *)createSessiontoAccount:(NSString *)toAccount;

+ (RACSignal *)pageMsgHistoryDateTimeMills:(NSString *)dateTimeMills userId:(NSString *)userId pageSize:(NSNumber *)pageSize;
@end

NS_ASSUME_NONNULL_END
