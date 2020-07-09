//
//  EFBaseRefreshVM.h
//  flag
//
//  Created by zclee on 2020/5/25.
//  Copyright © 2020 zclee. All rights reserved.
//

#import "EFBaseVM.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBaseRefreshVM : EFBaseVM

@property (nonatomic, strong) NSNumber *paging;                 //翻页当前的页码，默认为0
@property (nonatomic, strong, readonly) NSNumber *firstPage;    //第一页，默认为1
@property (nonatomic, strong) NSNumber *branches;               //每页的总条数，默认为100


/**
 下拉刷新方法

 @param network 网络请求的signal
 @param map 映射结果
 @return RACSignal
 */
- (RACSignal *)refreshForDown:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map;

/**
 子类如果添加了下拉头部，请在vm中重写本方法，并实现”- (RACSignal *)refreshForDown:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map“函数
 example:
 - (RACSignal *)refreshForDown
 {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [RACSignal empty];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = ....【请解析FMHttpResonse的reqResult成list后返回】
        return list;
    }];
 }
 
 @return RACSignal
 */
- (RACSignal *)refreshForDown;

/**
 上拉加载更多的方法

 @param network 网络请求的signal
 @param map 映射结果
 @return RACSignal
 */
- (RACSignal *)refreshForUp:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map;

/**
 子类如果添加了上拉头部，请在vm中重写本方法，并实现”- (RACSignal *)refreshForUp:(RACSignal *(^)(void))network toMap:(NSArray *(^)(FMHttpResonse *result))map“函数
 example:
 - (RACSignal *)refreshForUp
 {
    return [self refreshForDown:^RACSignal * _Nonnull{
        return [RACSignal empty];
    } toMap:^NSArray * _Nonnull(FMHttpResonse * _Nonnull result) {
        NSArray *list = ....【请解析FMHttpResonse的reqResult成list后返回】
        return list;
    }];
 }

 @return RACSignal
 */
- (RACSignal *)refreshForUp;

/**
 当前网络请求上拉或者下拉请求的区分枚举字段

 @return 区分当前一次网络请求是上拉还是下拉
 */
- (kFGRefresh)currentRequestRefreshState;
@end

NS_ASSUME_NONNULL_END
