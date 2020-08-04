//
//  EFUserModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/4.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFUserModel : EFBaseModel

@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *headImgUrl;
@property (nonatomic,assign)NSInteger sex;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,assign)BOOL isPhone;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *wxname;
@property (nonatomic,assign)BOOL isPassword;
@property (nonatomic,assign)BOOL isWeChat;
@property (nonatomic,strong)NSString *username;

//自己参数
@property (nonatomic,assign)BOOL isLogin;

@end

NS_ASSUME_NONNULL_END
