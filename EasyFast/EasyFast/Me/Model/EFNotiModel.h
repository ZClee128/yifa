//
//  EFNotiModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/18.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFNotiModel : EFBaseModel

/// 通知结束时间，格式：时分
@property (nonatomic,strong)NSString *endTime;
/// 通知开始时间，格式：时分
@property (nonatomic,strong)NSString *startTime;
/// 是否消息提醒，0：否；1：是；
@property (nonatomic,assign)BOOL isMessageRemind;
/// 是否震动提醒，0：否；1：是；
@property (nonatomic,assign)BOOL isVibrationRemind;
/// 是否声音提醒，0：否；1：是；
@property (nonatomic,assign)BOOL isVoiceRemind;

@end

NS_ASSUME_NONNULL_END
