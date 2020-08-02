//
//  EFCalendarView.h
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EFCalendarView : UIView

@property (nonatomic,copy)void(^seletDay)(CalendarModel *model);

- (instancetype)initWithFrame:(CGRect)frame withData:(NSMutableArray *)data;

@end

NS_ASSUME_NONNULL_END
