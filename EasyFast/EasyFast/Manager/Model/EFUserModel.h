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
@property (nonatomic,assign)NSInteger isPhone;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *wxname;
@property (nonatomic,assign)NSInteger isPassword;
@property (nonatomic,assign)NSInteger isWeChat;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *userSig;
@property (nonatomic,strong)NSString *uuNo;

//自己参数
@property (nonatomic,assign)NSInteger isLogin;

@end

NS_ASSUME_NONNULL_END
