//
//  UserManager.m
//  EasyFast
//
//  Created by easyfast on 2020/8/4.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "UserManager.h"
#import "LoginVM.h"

@implementation UserManager

+ (instancetype)defaultManager {
    static UserManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [UserManager new];
    });
    return _sharedManager;
}

- (EFUserModel *)userModel{
    if (!_userModel) {
        NSArray* finfAlls = [EFUserModel bg_findAll:nil];
        for (EFUserModel *model in finfAlls) {
            if (model.isLogin) {
                _userModel = model;
            }
        }
    }
    return _userModel;
}
@end
