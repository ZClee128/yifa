//
//  EFFootPrint.m
//  EasyFast
//
//  Created by easyfast on 2020/8/10.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFootPrint.h"

@implementation EFFootPrint

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [EFGoodsList class],
             };
}

@end
