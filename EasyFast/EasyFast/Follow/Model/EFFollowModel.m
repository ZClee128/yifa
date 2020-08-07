//
//  EFFollowModel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/6.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFFollowModel.h"

@implementation FollowTeamModel



@end

@implementation EFFollowModel

// 设置集合属性中的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [EFGoodsList class],
             };
}

@end
