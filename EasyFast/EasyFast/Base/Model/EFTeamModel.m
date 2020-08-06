//
//  EFTeamModel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFTeamModel.h"

@implementation EFTeamOrderDtoListModel



@end


@implementation EFTeamModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"teamOrderDtoList" : [EFTeamOrderDtoListModel class],
             };
}

@end
