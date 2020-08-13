//
//  EFTeamVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFTeamVM.h"

@implementation EFTeamVM

- (RACSignal *)refreshForDown {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageTeamByGoodsNoGGNo:self.ggNO orderBy:self.orderBy pageNum:self.firstPage pageSize:self.branches teamInfo:self.teamInfo type:self.type];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFTeamListModel class] json:result.reqResult];
        return list;
    }];
}


- (RACSignal *)refreshForUp {
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] pageTeamByGoodsNoGGNo:self.ggNO orderBy:self.orderBy pageNum:@([self.paging intValue] + 1) pageSize:self.branches teamInfo:self.teamInfo type:self.type];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = [NSArray modelArrayWithClass:[EFTeamListModel class] json:result.reqResult];
        return list;
    }];
}

+ (RACSignal *)goodsSummaryGGNo:(NSString *)ggNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] goodsSummaryGGNo:ggNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFTeamGoodsModel *model = [EFTeamGoodsModel modelWithJSON:result.reqResult];
        return model;
    }];
}

+ (RACSignal *)teamInfo:(NSString *)ootNo {
    return [self requsetNetwork:^RACSignal * _Nonnull{
        return [[FMARCNetwork sharedInstance] teamInfo:ootNo];
    } toMap:^id _Nonnull(FMHttpResonse * _Nonnull result) {
        EFTeamListModel *model = [EFTeamListModel modelWithJSON:result.reqResult];
        return model;
    }];
}
@end
