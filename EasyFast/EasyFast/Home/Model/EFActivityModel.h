//
//  EFActivityModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFActivityModel : EFBaseModel

/// 活动内容，暂时以H5展示
@property (nonatomic,strong)NSString *content;
/// 活动图标
@property (nonatomic,strong)NSString *icon;
/// 首页展示的活动标题-图标下方展示的名称
@property (nonatomic,strong)NSString *iconTitle;
/// 活动编码no
@property (nonatomic,strong)NSString *ppaNo;
/// 排序号
@property (nonatomic,strong)NSString *sortNum;
/// 活动标题-用于H5展示的文章标题
@property (nonatomic,strong)NSString *title;
/// 链接
@property (nonatomic,strong)NSString *url;

@end

NS_ASSUME_NONNULL_END
