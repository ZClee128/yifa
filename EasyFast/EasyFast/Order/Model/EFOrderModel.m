//
//  EFOrderModel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/7.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFOrderModel.h"

@implementation EFOrderGoodsModel



@end


@implementation EFOrderModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [EFOrderGoodsModel class],
             };
}


@end
