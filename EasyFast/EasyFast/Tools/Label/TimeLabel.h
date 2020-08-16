//
//  TimeLabel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/16.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "QMUILabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeLabel : QMUILabel

-(void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate;
@end

NS_ASSUME_NONNULL_END
