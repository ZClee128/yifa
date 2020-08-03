//
//  FMARCNetwork+Login.m
//  EasyFast
//
//  Created by easyfast on 2020/8/3.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "FMARCNetwork+Login.h"

@implementation FMARCNetwork (Login)

- (RACSignal *)userLogin {
    return [self fg_postRequest:kUserLogin paramters:@{@"type":@"1",@"account":@"13413686126",@"password":@"123"}];
}

@end
