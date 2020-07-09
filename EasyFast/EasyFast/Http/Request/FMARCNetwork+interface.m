//
//  FMARCNetwork+interface.m
//  flag
//
//  Created by zclee on 2020/5/25.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "FMARCNetwork+interface.h"
#import "FMHttpRequest.h"

@implementation FMARCNetwork (interface)


- (RACSignal *)fg_request:(FMHttpRequest *)request
{
    return [self requestNetworkData:request];
}

- (RACSignal *)fg_requestSimpleNetwork:(NSString *)path paramters:(nullable NSDictionary *)paramters
{
    return [self requestSimpleNetworkPath:path params:paramters];
}

- (RACSignal *)fg_getRequest:(NSString *)path paramters:(nullable NSDictionary *)paramters
{
    FMHttpRequest *request = [FMHttpRequest urlParametersWithMethod:HTTP_METHOD_GET path:path parameters:paramters];
    return [self fg_request:request];
}

- (RACSignal *)fg_postRequest:(NSString *)path paramters:(nullable NSDictionary *)paramters
{
    FMHttpRequest *request = [FMHttpRequest urlParametersWithMethod:HTTP_METHOD_POST path:path parameters:paramters];
    return [self fg_request:request];
}

- (RACSignal *)fg_putRequest:(NSString *)path paramters:(nullable NSDictionary *)paramters
{
    FMHttpRequest *request = [FMHttpRequest urlParametersWithMethod:HTTP_METHOD_PUT path:path parameters:paramters];
    return [self fg_request:request];
}
@end
