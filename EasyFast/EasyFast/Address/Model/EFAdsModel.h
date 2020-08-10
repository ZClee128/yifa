//
//  EFAdsModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/10.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFAdsModel : EFBaseModel

/// 详细地址
@property (nonatomic,strong)NSString *address;
/// 区
@property (nonatomic,strong)NSString *area;
/// 市
@property (nonatomic,strong)NSString *city;
/// 省
@property (nonatomic,strong)NSString *province;
/// 姓名
@property (nonatomic,strong)NSString *recipientName;
/// 联系电话
@property (nonatomic,strong)NSString *recipientPhone;
/// 地址编号
@property (nonatomic,strong)NSString *uuaNo;
/// 是否默认，0：否；1：是；
@property (nonatomic,assign)NSInteger isDefault;
/// 是否置顶，0：否；1：是；
@property (nonatomic,assign)NSInteger isSort;
@end

NS_ASSUME_NONNULL_END
