//
//  NSDate+Format.m
//  EasyFast
//
//  Created by easyfast on 2020/8/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

- (NSDate *)StringToDateFormatter:(NSString *)str date:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:str];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:zone];
    NSDate *date = [formatter dateFromString:time];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

- (NSString *)DateToStringFormatter:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:str];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}
@end
