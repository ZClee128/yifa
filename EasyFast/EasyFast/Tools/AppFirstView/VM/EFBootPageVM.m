//
//  EFBootPageVM.m
//  EasyFast
//
//  Created by easyfast on 2020/8/26.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBootPageVM.h"
@implementation EFBootpageModel


@end

@implementation EFBootPageVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *images = @[
                            @{
                                @"bgImage": @"first_one",
                                @"title" : @"一站式批发直供",
                                @"subTitle" : @"火拼百万工厂",
                                @"bacgroudColor" : RGB16(0xFFC75B),
                                @"titletop" : @3.5,
                                },
                            @{
                                @"bgImage": @"first_two",
                                @"title" : @"0成本的批发市场",
                                @"bacgroudColor" : RGB16(0xF44E42),
                                @"titletop" : @20.5,
                                },
                            @{
                                @"bgImage": @"first_three",
                                @"title" : @"暖心, 贴心的服务",
                                @"bacgroudColor" : RGB16(0xFF8339),
                                @"titletop" : @21,
                                },];
        self.dataSources = [[NSArray modelArrayWithClass:[EFBootpageModel class] json:images] mutableCopy];
    }
    return self;
}
@end
