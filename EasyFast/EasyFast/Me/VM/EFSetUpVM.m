//
//  EFSetUpVM.m
//  EasyFast
//
//  Created by zclee on 2020/7/20.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFSetUpVM.h"

@implementation EFSetUpVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSources = [@[@[@{@"title":@"切换账号",@"subTitle":@""},
                                @{@"title":@"账号与安全",@"subTitle":@""},
                                @{@"title":@"隐私",@"subTitle":@""}],
                              @[@{@"title":@"消息提醒通知",@"subTitle":@""},
                                @{@"title":@"清除缓存",@"subTitle":@""},
                                @{@"title":@"我的支付",@"subTitle":@""},
                                @{@"title":@"当前版本",@"subTitle":kVersion},
                                @{@"title":@"意见反馈",@"subTitle":@""},
                                @{@"title":@"关于我们",@"subTitle":@"客服电话：4008808880"}
                              ]] mutableCopy];
    }
    return self;
}


@end
