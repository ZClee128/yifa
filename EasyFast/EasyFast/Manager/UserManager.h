//
//  UserManager.h
//  EasyFast
//
//  Created by easyfast on 2020/8/4.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

@property (nonatomic,strong)EFUserModel *userModel;
+ (instancetype)defaultManager;
- (void)saveUserModel:(EFUserModel *)model;
@end

NS_ASSUME_NONNULL_END
