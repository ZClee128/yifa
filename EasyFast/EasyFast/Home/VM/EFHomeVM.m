//
//  EFHomeVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFHomeVM.h"


@implementation EFHomeVM

+ (RACSignal *)activity {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] activity];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFActivityModel class] json:result.reqResult];
        return list;
    }];
}


+ (RACSignal *)banner {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] banner];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFBannerModel class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)notice {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] notice];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFNoticeModel class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] HomePageNum:self.firstPage pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        XYLog(@"list >> %@",list);
        return list;
    }];
}

- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] HomePageNum:@([self.paging intValue] + 1) pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshOtherForDown:(NSString *)ggcsCode {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageGoodsByCategoryggcsCode:ggcsCode orderBy:self.orderBy PageNum:self.firstPage pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

- (RACSignal *)refreshOtherForUp:(NSString *)ggcsCode {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageGoodsByCategoryggcsCode:ggcsCode orderBy:self.orderBy PageNum:@([self.paging intValue] + 1) pageSize:self.branches];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFGoodsList class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)fastOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] fastOrderBy:orderBy type:type PageNum:pageNum pageSize:pageSize];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFFastModel class] json:result.reqResult];
        return list;
    }];
}


@end
