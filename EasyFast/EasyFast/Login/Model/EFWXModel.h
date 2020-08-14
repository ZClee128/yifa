//
//  EFWXModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/14.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFWXModel : EFBaseModel

@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *country;
@property (nonatomic,strong)NSString *headimgurl;
@property (nonatomic,strong)NSString *language;
@property (nonatomic,strong)NSString *nickname;
@property (nonatomic,strong)NSString *openid;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,assign)NSInteger sex;
@property (nonatomic,strong)NSString *unionid;

@end

NS_ASSUME_NONNULL_END
