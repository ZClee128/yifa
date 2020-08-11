//
//  EFClassifyVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFClassifyVM.h"

@implementation EFClassifyVM

+ (RACSignal *)category {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] category];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFClassifyModel class] json:result.reqResult];
        return list;
    }];
}


+ (RACSignal *)categoryByPno:(NSString *)pCode {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] categoryByPno:pCode];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFClassifyModel class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)thirdCategory:(NSString *)pCode size:(NSString *)size {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] thirdCategory:pCode size:size];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFClassifyModel class] json:result.reqResult];
        return list;
    }];
}
@end
