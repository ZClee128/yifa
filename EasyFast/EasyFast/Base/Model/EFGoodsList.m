//
//  EFGoodsList.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFGoodsList.h"

@implementation EFTagsModel


@end

@implementation EFGoodsList

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"tags" : [EFTagsModel class],
             };
}
@end
