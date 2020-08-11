//
//  EFBannerModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFBannerModel : EFBaseModel

/// banner编码
@property (nonatomic,strong)NSString *ppbNo;
/// 排序号，从小到大排序
@property (nonatomic,strong)NSString *sortNum;
/// banner名称
@property (nonatomic,strong)NSString *title;
/// banner图片路径
@property (nonatomic,strong)NSString *url;

@end

NS_ASSUME_NONNULL_END
