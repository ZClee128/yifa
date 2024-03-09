//
//  EFMessageModel.m
//  EasyFast
//
//  Created by easyfast on 2020/9/4.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFMessageModel.h"

@implementation EFMessageModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"msgBody" : [EFMsgBody class],
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![dic[@"msgBody"] isKindOfClass:[NSNull class]]) {
        NSArray *arr = [dic[@"msgBody"] parseJSONStringToNSDictionary];
        self.msgBody = [NSArray modelArrayWithClass:[EFMsgBody class] json:arr];
    }
    return YES;
}

@end
