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

@interface EFHomeVM : EFBaseRefreshVM

@property (nonatomic,strong)NSNumber *orderBy;

+ (RACSignal *)activity;

+ (RACSignal *)banner;

+ (RACSignal *)notice;

- (RACSignal *)refreshOtherForDown:(NSString *)ggcsCode;

- (RACSignal *)refreshOtherForUp:(NSString *)ggcsCode;

+ (RACSignal *)fastOrderBy:(NSNumber *)orderBy type:(NSNumber *)type PageNum:(NSNumber *)pageNum pageSize:(NSNumber *)pageSize;


@end

NS_ASSUME_NONNULL_END
