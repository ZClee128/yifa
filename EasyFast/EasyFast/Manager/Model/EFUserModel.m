//
//  EFUserModel.m
//  EasyFast
//
//  Created by easyfast on 2020/8/4.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFUserModel.h"

@implementation EFUserModel

/**
 如果需要指定“唯一约束”字段, 在模型.m文件中实现该函数,这里指定 name和age 为“唯一约束”.
 */
+(NSArray *)bg_uniqueKeys{
    return @[@"username"];
}

@end
