//
//  EFAddressVM.h
//  EasyFast
//
//  Created by easyfast on 2020/8/10.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFAdsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFAddressVM : EFBaseRefreshVM

+ (RACSignal *)addAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area;

+ (RACSignal *)delAddress:(NSString *)addressNo;

+ (RACSignal *)setDefaultAddress:(NSString *)addressNo;

+ (RACSignal *)updateAddress:(NSString *)address city:(NSString *)city province:(NSString *)province recipientName:(NSString *)recipientName recipientPhone:(NSString *)recipientPhone area:(NSString *)area addressNo:(NSString *)addressNo;
@end

NS_ASSUME_NONNULL_END
