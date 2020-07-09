//
//  EFBaseVM.m
//  flag
//
//  Created by zclee on 2020/5/25.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseVM.h"

static NSTimeInterval count = 0;

@interface EFBaseVM ()
@property (nonatomic, strong) RACSubject *combineSubject;
@property (nonatomic, strong) RACDisposable *disposable;
@end

@implementation EFBaseVM

+ (RACSignal *)requsetNetwork:(RACSignal *(^)(void))network toMap:(id(^)(FMHttpResonse *result))map
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        RACSignal *signal = network();
        [[signal map:map] subscribeNext:^(id  _Nullable x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError * _Nullable error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release cool signal method in %@ class", self.class);
        }];
    }];
}

- (RACSignal *)requsetNetwork:(RACSignal *(^)(void))network toMap:(id(^)(FMHttpResonse *result))map
{
    return [EFBaseVM requsetNetwork:network toMap:map];
}

- (RACSubject *)combineLatest:(NSArray<RACSignal *> *)signals filter:(BOOL(^)(NSArray *conditions))filter
{
    @weakify(self);
    [[[RACSignal combineLatest:signals] subscribeOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self.combineSubject sendNext:@(filter(x.allObjects))];
    } completed:^{
        NSLog(@"release hot signal -> “self.combineSubject” in %@ class", self.class);
    }];
    return self.combineSubject;
}

- (RACSignal *)then:(RACSignal *)signal
{
    return nil;
}

- (void)intervalTimer:(NSTimeInterval)interval intervalBlock:(BOOL(^)(NSDate *date, NSTimeInterval currenctCount))block
{
    @weakify(self);
    if (self.disposable) {
        [self.disposable dispose];
        self.disposable = nil;
    }
    self.disposable = [[RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.0f] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self);
        count += interval;
        BOOL stopDisposable = block(x, count);
        if (stopDisposable) {
            [self.disposable dispose];
            self.disposable = nil;
            count = 0;
        }
    }];
}

#pragma mark - Lazy

- (RACSubject *)combineSubject
{
    if (!_combineSubject) {
        _combineSubject = [RACSubject subject];
    }
    return _combineSubject;
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [_combineSubject sendCompleted];
    _combineSubject = nil;
    if (_disposable) {
        [_disposable dispose];
        _disposable = nil;
        count = 0;
    }
//    NSLog(@"%@->ViewModel class execute dealloc completed !", self.class);
}
@end
