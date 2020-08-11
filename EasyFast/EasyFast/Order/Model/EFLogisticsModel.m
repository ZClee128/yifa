//
//  EFLogisticsModel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFLogisticsModel.h"

@implementation ExpressItemModel



@end


@implementation EFLogisticsModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"expressItemList" : [ExpressItemModel class],
             };
}

@end
