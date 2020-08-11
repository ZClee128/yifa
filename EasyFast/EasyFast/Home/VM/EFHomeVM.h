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
NS_ASSUME_NONNULL_BEGIN

@interface EFHomeVM : EFBaseRefreshVM

+ (RACSignal *)activity;

+ (RACSignal *)banner;

+ (RACSignal *)notice;

- (RACSignal *)refreshOtherForDown:(NSString *)ggcsCode;

- (RACSignal *)refreshOtherForUp:(NSString *)ggcsCode;
@end

NS_ASSUME_NONNULL_END
