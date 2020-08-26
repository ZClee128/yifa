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
                                },
                            @{
                                @"bgImage": @"first_two",
                                },
                            @{
                                @"bgImage": @"first_three",
                                },];
        self.dataSources = [[NSArray modelArrayWithClass:[EFBootpageModel class] json:images] mutableCopy];
    }
    return self;
}
@end
