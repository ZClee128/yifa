//
//  EFTeamListModel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/13.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFTeamListModel.h"

@implementation TeamOrderDtoModel



@end


@implementation EFTeamListModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"teamOrderDtoList" : [TeamOrderDtoModel class],
             };
}

@end
