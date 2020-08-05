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

- (void)saveUserModel:(EFUserModel *)model {
    if ([[EFUserModel bg_findAll:nil] count] != 0) {
        for (EFUserModel *user in [EFUserModel bg_findAll:nil]) {
            if (![user.username isEqualToString:model.username]) {
                user.isLogin = NO;
            }
            model.isLogin = YES;
            
        }
    }else {
        model.isLogin = YES;
        model.nickname = model.nickname.base64EncodeString;
    }
}

- (EFUserModel *)userModel{
    _userModel = nil;
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
