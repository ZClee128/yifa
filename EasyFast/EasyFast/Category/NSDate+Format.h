//
//  NSDate+Format.h
//  EasyFast
//
//  Created by easyfast on 2020/8/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Format)

- (NSDate *)StringToDateFormatter:(NSString *)str date:(NSString *)time;
- (NSString *)DateToStringFormatter:(NSString *)str;
- (NSTimeInterval)DateToNSTimeIntervalFormatter;
@end

NS_ASSUME_NONNULL_END
