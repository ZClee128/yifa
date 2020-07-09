//
//  FMARCNetwork+interface.h
//  flag
//
//  Created by zclee on 2020/5/25.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "FMARCNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMARCNetwork (interface)

//预留两个接口层方法，上层调用时使用，预留加密或者头部信息操作等
- (RACSignal *)fg_request:(FMHttpRequest *)request;
- (RACSignal *)fg_requestSimpleNetwork:(NSString *)path paramters:(nullable NSDictionary *)paramters;

//GET-POST-PUT
- (RACSignal *)fg_getRequest:(NSString *)path paramters:(nullable NSDictionary *)paramters;
- (RACSignal *)fg_postRequest:(NSString *)path paramters:(nullable NSDictionary *)paramters;
- (RACSignal *)fg_putRequest:(NSString *)path paramters:(nullable NSDictionary *)paramters;

@end

NS_ASSUME_NONNULL_END
