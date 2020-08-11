//
//  EFClassifyModel.m
//  EasyFast
//
//  Created by zclee on 2020/7/22.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFClassifyModel.h"

@implementation EFClassifyModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"children" : [EFClassifyModel class],
             };
}

@end
