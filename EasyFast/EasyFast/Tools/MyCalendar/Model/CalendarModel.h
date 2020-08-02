//
//  CalendarModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/2.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalendarModel : EFBaseModel

@property (nonatomic,strong)NSString *week;
@property (nonatomic,strong)NSString *day;
@property  (nonatomic,assign)BOOL isToday;
@property (nonatomic,assign)BOOL isSelect;
@property (nonatomic,assign)BOOL hasFoot;
@property (nonatomic,strong)NSString *dayStr;

@end

NS_ASSUME_NONNULL_END
