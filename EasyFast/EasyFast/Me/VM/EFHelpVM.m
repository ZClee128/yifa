//
//  EFHelpVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/12.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHelpVM.h"

@implementation EFHelpVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] helpCenterListPageNum:self.firstPage pageSize:self.branches title:self.title];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFHelpModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] helpCenterListPageNum:@([self.paging intValue] + 1) pageSize:self.branches title:self.title];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFHelpModel class] json:result.reqResult];
        return list;
    }];
}

@end
