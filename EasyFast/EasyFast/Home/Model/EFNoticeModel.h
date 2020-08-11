//
//  EFNoticeModel.h
//  EasyFast
//
//  Created by easyfast on 2020/8/11.
//  Copyright © 2020 EasyFast. All rights reserved.
//

#import "EFBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EFNoticeModel : EFBaseModel

/// 公告内容
@property (nonatomic,strong)NSString *content;
/// 活动编码no
@property (nonatomic,strong)NSString *ppaNo;
/// 排序号
@property (nonatomic,strong)NSString *sortNum;
/// 标题
@property (nonatomic,strong)NSString *title;
/// 链接
@property (nonatomic,strong)NSString *url;
@end

NS_ASSUME_NONNULL_END
