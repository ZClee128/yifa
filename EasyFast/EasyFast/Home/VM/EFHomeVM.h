//
//  EFHomeVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFActivityModel.h"
#import "EFBannerModel.h"
#import "EFNoticeModel.h"
#import "EFGoodsList.h"
#import "EFFastModel.h"
NS_ASSUME_NONNULL_BEGIN

/// 活动
static NSString *Homeactivity = @"activity";
/// banner
static NSString *Homebanner = @"banner";
/// banner原始数据
static NSString *HomebannerData = @"HomebannerData";
/// 公告
static NSString *Homenotice = @"notice";
/// 急速拼团
static NSString *Homefast = @"Homefast";
@interface EFHomeVM : EFBaseRefreshVM

@property (nonatomic,strong)NSNumber *orderBy;

+ (RACSignal *)activity;

+ (RACSignal *)banner;

+ (RACSignal *)notice;

- (RACSignal *)refreshOtherForDown:(NSString *)ggcsCode;

- (RACSignal *)refreshOtherForUp:(NSString *)ggcsCode;

+ (RACSignal *)fastOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;

- (RACSignal *)zipLoadUrl;
@end

NS_ASSUME_NONNULL_END
