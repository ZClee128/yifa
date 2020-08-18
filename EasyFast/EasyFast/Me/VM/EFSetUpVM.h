//
//  EFSetUpVM.h
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseRefreshVM.h"
#import "EFNotiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFSetUpVM : EFBaseRefreshVM

+ (RACSignal *)queyMessageRemind;
+ (RACSignal *)messageRemindType:(NSInteger )type endTime:(NSString *)endTime startTime:(NSString *)startTime isMessageRemind:(BOOL)isMessageRemind isVibrationRemind:(BOOL)isVibrationRemind isVoiceRemind:(BOOL)isVoiceRemind;
@end

NS_ASSUME_NONNULL_END
