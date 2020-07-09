//
//  EFBaseVM.h
//  flag
//
//  Created by zclee on 2020/5/25.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "RVMViewModel.h"
#import "FMHttpResonse.h"

typedef NS_ENUM(NSUInteger, kFGRefresh) {
    
    kFGRefreshPullDown     = 2233,
    kFGRefreshPullUp,
};

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseVM : RVMViewModel

@property (nonatomic, strong) NSMutableArray *dataSources;

/**
 网络请求api

 @param network 请求的RACSignal
 @param map 请求结果映射函数
 @return RACSignal
 */
- (RACSignal *)requsetNetwork:(RACSignal *(^)(void))network toMap:(id(^)(FMHttpResonse *result))map;
+ (RACSignal *)requsetNetwork:(RACSignal *(^)(void))network toMap:(id(^)(FMHttpResonse *result))map;

/**
 合并多个信号
 
 @param signals 信号集合，格式:@[RACSignalA, RACSignalB, ...]
 @param filter 过滤器，由方法本身返回一个信号集合的所有触发结果集合，外部返回一个bool值来决定信号的bool值状态
 @return RACSignal
 */
- (RACSubject *)combineLatest:(NSArray<RACSignal *> *)signals filter:(BOOL(^)(NSArray *conditions))filter;

/**
 添加一个RAC计时器，本计时器会再主线程发起回调

 @param interval 间隔触发时间
 @param block 回调事件，返回一个BOOL值，YES表示关闭计时器，NO表示不关闭计时器
 */
- (void)intervalTimer:(NSTimeInterval)interval intervalBlock:(BOOL(^)(NSDate *date, NSTimeInterval currenctCount))block;


@end

NS_ASSUME_NONNULL_END
