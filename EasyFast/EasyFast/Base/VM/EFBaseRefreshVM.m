//
//  EFBaseRefreshVM.m
//  flag
//
//  Created by zclee on 2020/5/25.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseRefreshVM.h"

@interface EFBaseRefreshVM ()

@property (nonatomic, assign, readonly) kFGRefresh currentRefreshState;

@end

@implementation EFBaseRefreshVM

- (instancetype)init
{
    if (self = [super init]) {
        _firstPage = @(1);
        _paging = @(self.firstPage.integerValue);
        _branches = @(100);
        _currentRefreshState = kFGRefreshPullDown;
    }
    return self;
}

#pragma mark - Getter

- (kFGRefresh)currentRequestRefreshState
{
    return self.currentRefreshState;
}

#pragma mark - Request Methods

- (RACSignal *)refreshOperation:(kFGRefresh)operation requsetNetwork:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        [[self requsetNetwork:network toMap:map] subscribeNext:^(NSArray *list) {
            @strongify(self);
            self->_currentRefreshState = operation;
            if (operation == kFGRefreshPullDown) {
                self.dataSources = [list mutableCopy];
                self->_paging = @(self.firstPage.integerValue);
                [subscriber sendNext:RACTuplePack(self.dataSources, list)];
                [subscriber sendCompleted];
                return;
            }
            for (id x in list) {
                [self.dataSources addObject:x];
            }
            self->_paging = @(self->_paging.integerValue + 1);
            [subscriber sendNext:RACTuplePack(self.dataSources, list)];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal method in ”%@“ class", self.class);
        }];
    }];
}

- (RACSignal *)refreshForDown
{
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [RACSignal empty];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

- (RACSignal *)refreshForDown:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map
{
    return [self refreshOperation:kFGRefreshPullDown requsetNetwork:network toMap:map];
}

- (RACSignal *)refreshForUp
{
    return [self refreshForUp:^RACSignal * _Nonnull{
        return [RACSignal empty];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        return result.reqResult;
    }];
}

- (RACSignal *)refreshForUp:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map
{
    return [self refreshOperation:kFGRefreshPullUp requsetNetwork:network toMap:map];
}

@end
